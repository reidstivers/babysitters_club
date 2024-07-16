class BookingsController < ApplicationController
  def create
    @booking = Booking.new(create_params)
    @booking.listing_id = params[:listing_id]
    @booking.user = current_user
    if @booking.save
      redirect_to listing_path(params[:listing_id])
    end
  end
private
  def create_params
    params.require(:booking).permit(:start_at, :end_at)
  end
end
