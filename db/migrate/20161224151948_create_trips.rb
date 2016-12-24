class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.references :route, foreign_key: true
      t.string :trip_headsign
      t.binary :direction_id
    end
  end
end
