class ReviewsController < ApplicationController
  before_action :set_booking
  before_action :set_listing

  def new
    @review = @booking.reviews.new
  end

  def create
    @review = @booking.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to listing_booking_path(@listing, @booking), notice: 'Review was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def review_params
    params.require(:review).permit(:comment)
  end
end
