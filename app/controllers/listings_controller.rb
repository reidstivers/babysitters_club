class ListingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    # Conditional statement to permit search bar usage on the index, using the pg_search gem
    # Searches listing.title, listing.description, user.first_name, user.last_name
    # Privacy not an issue for user because it only searches for listings posted by that user
    if params[:query].present?
      @listings = Listing.search_by_title_and_description(params[:query])
    else
      @listings = Listing.all
    end
    # create markers for use on the map
    @markers = @listings.geocoded.map do |listing|
      {
        lat: listing.latitude,
        lng: listing.longitude,
        # This adds an info window for each marker on the map
        info_window: render_to_string(partial: "popup", locals: {listing: listing}),
        marker_html: "<i class='fa-solid fa-baby-carriage fa-beat' style='color: #e44611; font-size: 24px;'></i>"
      }
    end
  end

  def sitter_listings
    @listings = current_user.listings
  end

  def show
    @listing = Listing.find(params[:id])
    @booking = Booking.new
    @bookings = @listing.bookings
    if @listing.geocoded?
      @markers = [{
        lat: @listing.latitude,
        lng: @listing.longitude,
      }]
    else
      @markers = []
    end
  end

  def new
    @listing = Listing.new
    @listing.availabilities.build
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
    params.require(:listing).permit(:title, :description, :fee, :location, photos: [], availabilities_attributes: [:id, :start_time, :end_time, :_destroy])
  end
end
