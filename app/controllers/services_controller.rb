class ServicesController < ApplicationController
  before_action :set_services, only: %i[show edit update destroy]
  def show
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to @service, notice: 'Service was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    redirect_to services_path
  end
  
  private

  def set_services
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :description)
  end
end
