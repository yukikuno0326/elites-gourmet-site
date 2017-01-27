class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :user_id
      t.string :telephone_number
      t.string :address
      t.boolean :has_private_room
      t.integer :seat_count
      t.datetime :open_date
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
