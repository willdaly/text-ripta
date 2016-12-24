class CreateRouteStops < ActiveRecord::Migration[5.0]
  def change
    create_table :route_stops do |t|
      t.references :route, foreign_key: true
      t.references :stop, foreign_key: true
      t.integer :order
    end
  end
end
