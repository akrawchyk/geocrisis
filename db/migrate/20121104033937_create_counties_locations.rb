class CreateCountiesLocations < ActiveRecord::Migration
  def change
    create_table :counties_locations, id: false do |t|
      t.integer :county_id, null: false
      t.integer :location_id, null: false
    end
  end
end

