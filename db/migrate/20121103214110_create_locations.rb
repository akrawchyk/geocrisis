class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city, null: false
      t.string :state, length: 2, null: false
      t.integer :county_id, null: false
    end
  end
end
