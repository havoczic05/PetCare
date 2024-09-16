class ActivitiesController < ApplicationController
  def index
    @booking = Booking.find(params[:booking_id])
    @start_date = @booking.start_date
    @end_date = @booking.end_date
    @activities = @booking.activities.group_by { |activity| activity.date }
  end

  def new
    @booking = Booking.find(params[:booking_id])
    @activity = Activity.new
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @activity = Activity.new(activity_params)
    @activity.booking_id = @booking.id
    if @activity.save
      redirect_to booking_activities_path, notice: 'Actividad creada con éxito.'
    else
      render :new
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :start_time, :end_time, :date)
  end
end
