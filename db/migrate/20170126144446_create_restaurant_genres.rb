class CreateRestaurantGenres < ActiveRecord::Migration
  def change
    create_table :restaurant_genres do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :genre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
