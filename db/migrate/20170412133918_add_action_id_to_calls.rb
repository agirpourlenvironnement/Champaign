class AddActionIdToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :action_id, :integer
  end
end
