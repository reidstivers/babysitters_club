class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_date, :end_date, presence: true
end
