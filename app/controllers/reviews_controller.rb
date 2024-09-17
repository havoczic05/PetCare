class ReviewsController < ApplicationController
  before_action :set_booking, only: %i[new create]
  before_action :set_service, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.booking_id = @booking.id
    if @review.save
     redirect_to service_path(@service)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_service
    @service = @booking.service
  end
end
