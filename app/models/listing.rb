class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  # Removed :listing from required fields to allow us to work for the demo
  # Need to add the listing back in later
  validates :title, :description, :fee, presence: true
  validates :description, length: { minimum: 10 }
end
