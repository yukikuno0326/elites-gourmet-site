class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  
  validates :restaurant_id, presence: true
  validates :user_id,       presence: true
  validates :rank,          presence: true, inclusion: 1..5
  validates :body,          presence: true, allow_blank: false
end
