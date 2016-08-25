# frozen_string_literal: true
json.array! @subscriptions do |subscription|
  json.call(subscription, :id, :billing_day_of_month, :created_at, :amount)
  json.transactions subscription.transactions, :id, :status, :amount, :created_at
end