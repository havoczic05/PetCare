class BookingsController < ApplicationController
  before_action :set_service
  before_action :set_booking, only: %i[show]

  def index
    @bookings = @service.booking
  end

  def new
    @booking = @service.booking.new
  end

  def create
    @booking = @service.booking.new(booking_params)
    if @booking.save
      redirect_to service_booking_path(@service, @booking), notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_service
    @service = Service.find(params[:service_id])
  end

  def set_booking
    @booking = @service.booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :message, :pet_id, :status)
  end
end
