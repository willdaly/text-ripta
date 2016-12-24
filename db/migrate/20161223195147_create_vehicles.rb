class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.references :trip, foreign_key: true
      t.references :route, foreign_key: true
      t.references :stop, foreign_key: true

      t.timestamps
    end
  end
end
