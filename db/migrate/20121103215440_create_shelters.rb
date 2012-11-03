class CreateShelters < ActiveRecord::Migration
  def change
    create_table :shelters do |t|
      t.string :name, null: false
      t.integer :location_id, null: false
    end
  end
end
