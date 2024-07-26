class AddFeeToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :fee, :integer
  end
end
