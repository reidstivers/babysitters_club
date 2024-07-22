class AddDefaultValueToBookingsStatus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :bookings, :status, 1
  end
end
