class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user
  has_one :listing, through: :booking
  validates :comment, presence: true
end
