class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings

  validates :title, :description, :price, presence: true
  validates :description, length: { minimum: 10 }
end
