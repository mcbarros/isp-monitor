class CreateDefaultRouteStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :default_route_statuses do |t|
      t.references :router_config, null: false, foreign_key: true
      t.string :route_id
      t.string :status

      t.timestamps
    end
  end
end
