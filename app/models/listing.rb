class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  has_many :availabilities, inverse_of: :listing, dependent: :destroy
  accepts_nested_attributes_for :availabilities, allow_destroy: true
  has_many_attached :photos

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  include PgSearch::Model
  # Implements pg_search gem to allow for search bar functionality
  # Associated to user to allow for searching for listing by sitter name
  pg_search_scope :search_by_title_and_description,
    against: [:title, :description],
    associated_against: {
    user: [:first_name, :last_name]
    },
    using: {
      tsearch: { prefix: true }
    }

  # Removed :listing from required fields to allow us to work for the demo
  # Need to add the listing back in later
  validates :title, :description, :fee, presence: true
  validates :description, length: { minimum: 10 }
end
