class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :title, :description, :fee, :location, presence: true
  validates :description, length: { minimum: 10 }
end
