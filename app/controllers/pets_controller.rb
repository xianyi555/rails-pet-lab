class PetsController < ApplicationController

  def index
    owner_id = params[:owner_id]
    @owner = Owner.find_by(id: owner_id)
  end

  def show
    pet_id = params[:id]
    @pet = Pet.find_by(id: pet_id)
  end

  def new
    owner_id = params[:owner_id]
    @owner = Owner.find_by(id: owner_id)
    @pet = Pet.new
  end

  def create
    owner_id = params[:owner_id]
    owner = Owner.find_by(id: owner_id)
    new_pet = Pet.new(pet_params)
    if new_pet.save
      owner.pets << new_pet
      redirect_to pet_path(new_pet)
    else
      # TODO: handle save errors and communicate issues to user
      render :new
    end
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :breed, :date_of_birth)
  end

end
