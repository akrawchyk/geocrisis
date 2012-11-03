class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :type, null: false
      t.string :content, null: false
      t.integer :location_id, null: false
    end
  end
end
