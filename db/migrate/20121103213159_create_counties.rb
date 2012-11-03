class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name, null: false
      t.string :fip, null: false
    end
  end
end
