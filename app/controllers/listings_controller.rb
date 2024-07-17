class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
    @booking = Booking.new
    @bookings = @listing.bookings
  end

  def new
    @listing = Listing.new
  end
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :new, status: :unprocessable_entity
    end
  end

private
  def listing_params
    params.require(:listing).permit(:title, :description, :fee, :location)
  end
end
