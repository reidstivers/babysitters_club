class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    # Reorders bookings by their start_at date
    @bookings = @bookings.order(:start_at)
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
    Rails.logger.info "Received booking params; #{params[:booking].inspect}"
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "Booking updated successfully"
    else
      render "bookings/show", status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :notes, :status, :comments)
  end
end
