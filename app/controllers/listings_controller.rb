class ListingsController < ApplicationController
  def index
    @listings = Listing.all
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def new
    @listing = Listing.new
  end
  def create
    @listing = Listing.new(listing_params)
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
