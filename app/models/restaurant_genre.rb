class RestaurantGenre < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :genre
end
