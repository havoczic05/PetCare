class PetsController < ApplicationController
  before_action :set_pets, only: %i[edit update destroy]
  def edit
  end

  def update
    redirect_to pets_path, notice: 'Pet was successfully updated.' if @pet.update(pet_params)
  end

  def destroy
    @vpet.destroy
    flash[:notice] = 'Pet was deleted.'
    redirect_to pets_path
  end

  private
  def set_pets
    params@pet = Pet.find(params[:id])
  end

end
