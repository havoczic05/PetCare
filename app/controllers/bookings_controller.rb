class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, except: %i[accept reject index]
  before_action :set_booking, only: %i[show]

  def index
    @bookings = Booking.joins(pet: :user).where(pets: { user_id: current_user.id })
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = @service.bookings.new(booking_params)
    @booking.status = "pending"
    if @booking.save
      redirect_to service_booking_path(@service, @booking), notice: 'Booking was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def total_days(booking)
    return 0 unless booking.start_date && booking.end_date

    (booking.end_date - booking.start_date).to_i
  end

  def total_price(booking)
    days = total_days(booking)
    return booking.service.price.to_f if days.zero?

    return (booking.service.price * total_days(booking)).to_f
  end

  def show
    @total_price = total_price(@booking)
  end

  def accept
    @booking = Booking.find(params[:id])
    @booking.update(status: "confirmed")
    respond_to do |format|
      format.turbo_stream { render "bookings/update_status" }
    end
  end

  def reject
    @booking = Booking.find(params[:id])
    @booking.update(status: "rejected")

    respond_to do |format|
      format.turbo_stream { render "bookings/update_status" }
    end
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
