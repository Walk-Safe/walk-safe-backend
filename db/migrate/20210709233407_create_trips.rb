class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :start_point
      t.string :end_point
      t.integer :travel_mode
      t.string :start_lat
      t.string :start_lon
      t.string :end_lat
      t.string :end_lon
      t.integer :eta
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
