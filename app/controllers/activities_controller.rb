class ActivitiesController < ApplicationController
  before_action :set_booking, only: %i[index new create edit]
  before_action :set_activity, only: %i[edit update destroy]

  def index
    @start_date = @booking.start_date
    @end_date = @booking.end_date
    @activities = @booking.activities.group_by { |activity| activity.date }
  end


  def new
    @activity = Activity.new
    @start_date = @booking.start_date
    @end_date = @booking.end_date
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.booking_id = @booking.id
    if @activity.save
      redirect_to booking_activities_path, notice: 'Actividad creada con éxito.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: 'Activity was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy!
    redirect_to booking_activities_path, notice: 'Activity was successfully deleted.'
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :description, :start_time, :end_time, :date)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
end
