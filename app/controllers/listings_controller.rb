class ListingsController < ApplicationController

  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
    @booking = Booking.new
    @bookings = @listing.bookings
    if @listing.geocoded?
      @markers = [{
        lat: @listing.latitude,
        lng: @listing.longitude,
        marker_html: render_to_string(partial: "listings/marker")
      }]
    else
      @markers = []
    end
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user
    if @listing.save
      redirect_to listing_path(@listing), notice: "Listing created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def listing_params
    params.require(:listing).permit(:title, :description, :fee, :location, photos: [])
  end
end
