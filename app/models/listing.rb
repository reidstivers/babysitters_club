class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many_attached :photos

  validates :title, :description, :fee, :location, presence: true
  validates :description, length: { minimum: 10 }
end
