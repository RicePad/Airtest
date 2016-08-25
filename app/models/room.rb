class Room < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :reservations
  has_many :reviews


  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bed_room, presence: true
  validates :bath_room, presence: true
  validates :listing_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 50}
  validates :address, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: true

  def average_rating
      # chek reviews count and if there are 0 reviews return 0 otherwise if we have reviews gives the reviews average and round to 2 decimal.
    reviews.count == 0 ? 0 : reviews.average(:star).round(2)
  end

end


