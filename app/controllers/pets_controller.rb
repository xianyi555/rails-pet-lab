class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    pet_params = params.require(:pet).permit(:name, :breed)
    pet = Pet.create(pet_params)
    redirect_to pet_path(pet)
  end

  def show
    pet_id = params[:id]
    @pet = Pet.find_by_id(pet_id)
  end

end