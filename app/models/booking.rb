class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :start_at, :end_at, presence: true
  validates_datetime :end_at, on_or_after: :start_at
end
