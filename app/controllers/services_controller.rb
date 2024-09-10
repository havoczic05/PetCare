class ServicesController < ApplicationController
  # before_action :set_user

  def index
    @services = Service.all
  end

  def new
    @service = @user.services.build
  end

  def create
    @service = @user.services.build(service_params)
    redirect_to @service, notice: 'Service created' if @service.save
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def service_params
    params.require(:service).permit(:price, :description, :address, :latitude, :longitude, :restrictions, :house_description)
  end
end
