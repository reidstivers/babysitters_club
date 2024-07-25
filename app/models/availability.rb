class Availability < ApplicationRecord
  belongs_to :listing

  scope :overlapping, ->(start_time, end_time) {
    where.not("start_time > ? OR end_time < ?", end_time, start_time)
  }
end
