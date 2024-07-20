class ChangeDateToDateTimeInBookings < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :start_at, :datetime
    change_column :bookings, :end_at, :datetime
  end
end
