class ChangeTripsColumnRemoveLatLonAddEtaString < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :eta_string, :string
    remove_column :trips, :start_lat, :string
    remove_column :trips, :start_lon, :string
    remove_column :trips, :end_lat, :string
    remove_column :trips, :end_lon, :string
  end
end
