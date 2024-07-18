class BookingsController < ApplicationController

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @booking.user = current_user
    @listing = Listing.find(params[:listing_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.listing_id = params[:listing_id]
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(params[:booking_id]), notice: "Booking created successfully"
    else
      redirect_to listing_path(params[:listing_id]), status: :unprocessable_entity
    end
  end

private

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :notes)
  end
end
