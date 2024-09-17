class ServicesController < ApplicationController
  # before_action :set_user
  before_action :set_service, only: %i[show edit update destroy]
  def index
    @services = Service.where(user: current_user)
    @bookings = @services.map(&:bookings).flatten
  end

  def landing
    @services = Service.all
    @services = if params[:specie]
                  Service.where(specie: params[:specie])
                else
                  Service.all
                end
    if params[:query].present?
      @services = @services.where('address ILIKE ?', "%#{params[:query]}%")
      # @services = @services.where(address: params[:query])
    end
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user_id = current_user.id
    if @service.save
      redirect_to @service, notice: '🎉 Your service was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @marker = {
      lat: @service.latitude,
      lng: @service.longitude,
      info_window_html: render_to_string(partial: "info_window", locals: { service: @service })
    }
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: '🎉 Your service was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy!
    redirect_to services_path, notice: '😔 Your service was successfully deleted.'
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:price, :description, :address, :specie, :restrictions, :house_description, :photo, :longitude, :latitude)
  end
end
