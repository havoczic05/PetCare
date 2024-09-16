class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, except: %i[accept_booking reject_booking index]
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

  def accept_booking
    puts "accept_booking"
    @booking = Booking.find(params[:id])
    @booking.update(status: "confirmed")
    redirect_to services_path, notice: 'Booking was successfully accepted.'
  end

  def reject_booking
    puts "reject_booking"
    @booking = Booking.find(params[:id])
    @booking.update(status: "rejected")
    redirect_to services_path, notice: 'Booking was successfully rejected.'
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
