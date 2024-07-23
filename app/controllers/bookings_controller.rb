class BookingsController < ApplicationController
  def index
    @bookings = current_user.bookings
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
    @listing = Listing.find(params[:listing_id])
    @booking.listing = @listing
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking created successfully"
    else
      render "listings/show", status: :unprocessable_entity
    end
  end

  def update
    @booking = Booking.find(params[:id])
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "Booking updated successfully"
    else
      render "bookings/show", status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :notes, :status)
  end
end
