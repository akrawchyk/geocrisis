class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :code, null: false
      t.integer :location_id, null: false
    end
  end
end
