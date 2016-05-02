class PetsController < ApplicationController

  def index
    owner_id = params[:owner_id]
    @owner = Owner.find_by(id: owner_id)
  end

  def new
    @pet = Pet.new
    owner_id = params[:owner_id]
    @owner = Owner.find_by(id: owner_id)
  end

  def create
    owner = Owner.find(params[:owner_id])
    new_pet = Pet.new(pet_params)
    if new_pet.save
      owner.pets << new_pet
      redirect_to owner_pet_path(owner, new_pet)
    else
      flash[:error] = new_pet.errors.full_messages.join(", ")
      redirect_to new_owner_pet_path(owner)
    end
  end

  def show
    pet_id = params[:id]
    @pet = Pet.find_by(id: pet_id)
    owner_id = params[:owner_id]
    @owner = Owner.find_by(id: owner_id)
  end

  def edit
    pet_id = params[:id]
    @pet = Pet.find_by(id: pet_id)
    owner_id = params[:owner_id]
    @owner = Owner.find_by(id: owner_id)
  end

  def update
    owner_id = params[:owner_id]
    owner = Owner.find_by(id: owner_id)
    pet_id = params[:id]
    pet = Pet.find_by(id: pet_id)

    if pet.update(pet_params)
      flash[:notice] = "Updated successfully."
      redirect_to owner_pet_path(owner, pet)
    else
      flash[:error] = pet.errors.full_messages.join(", ")
      redirect_to edit_owner_pet_path(owner, pet)
    end
  end

  def destroy
    pet_id = params[:id]
    pet = Pet.find_by(id: pet_id)
    pet.delete

    owner_id = params[:owner_id]
    owner = Owner.find_by(id: owner_id)
    redirect_to owner_pets_path(owner)
  end

  private
  def pet_params
    params.require(:pet).permit(:name, :breed, :date_of_birth)
  end

end
