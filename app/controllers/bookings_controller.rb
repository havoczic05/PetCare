class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, except: :accept_booking
  before_action :set_booking, only: %i[show]

  def index
    @bookings = @service.bookings
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @service.bookings.new(booking_params)
    @booking.status = false
    if @booking.save
      redirect_to service_booking_path(@service, @booking), notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def accept_booking
    @booking = Booking.find(params[:id])
    @booking.update(status: true)
    redirect_to services_path, notice: 'Booking was successfully accepted.'
  end

  private

  def set_service
    @service = Service.find(params[:service_id])
  end

  def set_booking
    @booking = @service.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :message, :pet_id, :status)
  end
end
