class BookingsController < ApplicationController
  before_action :set_listing, only: [:new, :create]
  before_action :set_booking, only: [:show, :update]

  def index
    @bookings = Booking.all
    # Reorders bookings by their start_at date
    @bookings = @bookings.order(:start_at)
  end

  def show
    # @booking is already set by the before_action
  end

  def new
    @booking = Booking.new
    @booking.user = current_user
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.listing = @listing
    @booking.user = current_user
    if @booking.save
      redirect_to booking_path(@booking), notice: "Booking created successfully"
    else
      render "listings/show", status: :unprocessable_entity
    end
  end

  def update
    # @booking is already set by the before_action
    Rails.logger.info "Received booking params; #{params[:booking].inspect}"
    if @booking.update(booking_params)
      redirect_to booking_path(@booking), notice: "Booking updated successfully"
    else
      render "bookings/show", status: :unprocessable_entity
    end
  end

  private

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
    @listing = @booking.listing
  end

  def booking_params
    params.require(:booking).permit(:start_at, :end_at, :notes, :status, :comments, :fee)
  end
end
