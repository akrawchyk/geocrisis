class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name,                     null: false
      t.string :type,                     null: false
      t.string :address,                  null: false
      t.string :city,                     null: false
      t.string :state, length: 2,         null: false
      t.string :phone, length: 10,        null: false
      t.string :zip,                      null: false
      t.integer :location_id,             null: false
    end
  end
end
