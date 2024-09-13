class ActivitiesController < ApplicationController
  def index
    @booking = Booking.find(params[:booking_id])
    @start_date = Date.parse(@booking.start_date.strftime)
    @end_date = Date.parse(@booking.end_date.strftime)
    @activities = Activity.all.group_by {|activity| activity.start_time.to_date}
    #debugger
    #@activities = Activity.joins(:booking).where("booking.start_date")
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
