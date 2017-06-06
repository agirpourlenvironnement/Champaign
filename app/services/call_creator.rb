# frozen_string_literal: true
class CallCreator
  include Rails.application.routes.url_helpers

  def initialize(params)
    @params = params.clone
    @errors = {}
  end

  def run
    sanitize_params!
    @page = Page.find(@params[:page_id])
    @call = Call.new(page: @page,
                     member_id: @params[:member_id],
                     member_phone_number: @params[:member_phone_number],
                     target_id: @params[:target_id])

    validate_target
    validate_call_tool

    if errors.blank?
      Call.transaction do
        place_call if @call.save
      end

      if @call.persisted? && !@call.failed?
        create_action
        publish_event
      end
    end

    errors.blank?
  end

  def errors
    @call.errors.messages.clone.tap do |e|
      @errors.each do |key, val|
        e[key] ||= []
        e[key] += val
      end
    end
  end

  private

  def sanitize_params!
    if @params[:member_phone_number].present?
      @params[:member_phone_number] = Phony.normalize(@params[:member_phone_number])
    end
  rescue Phony::NormalizationError
  end

  # TODO: Move method to service class, handle error messages in there.
  def place_call
    client = Twilio::REST::Client.new.account.calls
    client.create(
      from: @call.caller_id,
      to: @call.member_phone_number,
      url: call_start_url(@call),
      status_callback: member_call_event_url(@call),
      status_callback_method: 'POST',
      status_callback_event: %w(initiated ringing answered completed)
    )
  rescue Twilio::REST::RequestError => e
    # 13223: Dial: Invalid phone number format
    # 13224: Dial: Invalid phone number
    # 13225: Dial: Forbidden phone number
    # 13226: Dial: Invalid country code
    # 21211: Invalid 'To' Phone Number
    # 21214: 'To' phone number cannot be reached
    @call.update!(twilio_error_code: e.code, status: 'failed')
    if (e.code >= 13_223 && e.code <= 13_226) || [21_211, 21_214].include?(e.code)
      add_error(:member_phone_number, I18n.t('call_tool.errors.phone_number.cant_connect'))
    else
      Rails.logger.error("Twilio Error: API responded with code #{e.code} for #{@call.attributes.inspect}")
      add_error(:base, I18n.t('call_tool.errors.unknown'))
    end
  end

  def create_action
    return if @call.member.blank?
    @action = Action.create!(
      page: @page,
      member: @call.member,
      form_data: {
        phone: @call.member_phone_number,
        action_call_status: @call.status,
        action_target_call_status: @call.target_call_status,
        action_target: @call.target.to_hash
      }
    )
    @call.update!(action: @action)
  end

  def publish_event
    return if @action.blank?
    ActionQueue::Pusher.push(:new_call, @action)
  end

  # If the targets are updated while the user is on the call tool page, the list
  # of target_ids on the browser are no longer valid.
  # This validation checks for this edge case.
  def validate_target
    if @call.target.blank? && @params[:target_id].present?
      add_error(:base, I18n.t('call_tool.errors.target.outdated'))
    end
  end

  def validate_call_tool
    if @call.caller_id.blank?
      add_error(:base, 'Please configure a Caller ID before trying to use the call tool')
    end
  end

  def add_error(key, message)
    @errors[key] ||= []
    @errors[key] << message
  end
end
