class AddCheckConfigToRouterConfig < ActiveRecord::Migration[7.2]
  def change
    change_table :router_configs do |t|
      t.boolean :recurrent_checks, default: false
      t.string :notification_email
      t.integer :max_check_entries, default: 0
    end
  end
end
