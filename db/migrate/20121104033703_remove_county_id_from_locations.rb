class RemoveCountyIdFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :county_id
  end
end
