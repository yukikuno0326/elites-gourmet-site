class CreateRestaurantImages < ActiveRecord::Migration
  def change
    create_table :restaurant_images do |t|
      t.integer :restaurant_id
      t.string :image

      t.timestamps null: false
    end
  end
end
