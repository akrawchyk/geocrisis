class ZipcodesAdjustments < ActiveRecord::Migration
  def change
    change_column :zipcodes, :location_id, :integer, :null => true
    add_column :zipcodes, :county_id, :integer
  end
end
