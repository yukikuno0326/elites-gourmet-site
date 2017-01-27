class RestaurantImage < ActiveRecord::Base
  belongs_to :restaurant
  
  mount_uploader :image, RestaurantImageUploader
end
