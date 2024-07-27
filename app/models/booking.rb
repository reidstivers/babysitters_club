class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_many :reviews, dependent: :destroy
  before_save :calculate_fee

  validates :start_at, :end_at, presence: true
  validates_datetime :end_at, on_or_after: :start_at
  validate :availability_check
  validates :status, inclusion: { in: [1, 2, 3, 4] }

  private

  def availability_check
    overlaps = listing.availabilities.overlapping(start_at, end_at)
    if overlaps.blank?
      errors.add(:base, "The listing is not available during the selected time")
    end
  end

  def calculate_fee
    duration_in_hours = ((end_at - start_at) / 1.hour).to_f
    self.fee = (duration_in_hours * listing.fee).round
  end
end
