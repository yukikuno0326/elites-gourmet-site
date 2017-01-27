class Restaurant < ActiveRecord::Base
  has_many :restaurant_genres
  has_many :genres, through: :restaurant_genres
  has_many :restaurant_images, dependent: :destroy
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :restaurant_images
  
  geocoded_by :address
  after_validation :geocode
  
  validates :name, presence: true
  validates :user_id, presence: true
  validates :restaurant_genres, length: { minimum:1 }
  validates :telephone_number, presence: true
  validates :address, presence: true
  validates :has_private_room, inclusion: {in: [true, false]}
  validates :seat_count, presence: true, numericality: true
  validates_numericality_of :seat_count, greater_than: 0
  validates :open_date, presence: true
end
