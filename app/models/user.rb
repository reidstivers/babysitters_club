class User < ApplicationRecord
  has_many :listings
  has_many :bookings
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  validates :first_name, :last_name, :location, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
