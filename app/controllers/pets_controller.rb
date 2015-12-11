class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    pet_params = params.require(:pet).permit(:name, :breed)
    pet = Pet.new(pet_params)
    if pet.save
      redirect_to pet_path(pet)
    else
      flash[:error] = pet.errors.full_messages.join(", ")
      redirect_to new_pet_path
    end
  end

  def show
    pet_id = params[:id]
    @pet = Pet.find_by_id(pet_id)
  end

  def edit
    pet_id = params[:id]
    @pet = Pet.find_by_id(pet_id)
  end

  def update
    pet_id = params[:id]
    pet = Pet.find_by_id(pet_id)
    pet_params = params.require(:pet).permit(:name, :breed)
    if pet.update_attributes(pet_params)
      redirect_to pet_path(pet)
    else
      flash[:error] = pet.errors.full_messages.join(", ")
      redirect_to edit_pet_path(pet)
    end
  end

end