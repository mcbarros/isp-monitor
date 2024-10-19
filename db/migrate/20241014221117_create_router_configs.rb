class CreateRouterConfigs < ActiveRecord::Migration[7.2]
  def change
    create_table :router_configs do |t|
      t.string :name
      t.string :host
      t.integer :port
      t.string :user
      t.string :password

      t.timestamps
    end
  end
end
