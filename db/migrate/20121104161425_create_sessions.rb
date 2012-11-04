class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_hash
      t.string :latlng
      t.integer :location_id

      t.timestamps
    end
  end
end
