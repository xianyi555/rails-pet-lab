class PetsController < ApplicationController
  def index
    # TODO: set up data for index view
    # figure out who owner is (@potato)
    owner_id_from_url = params[:owner_id]
    @potato = Owner.find_by_id(owner_id_from_url)
    # figure out owner's pets (@pets)
    @pets = @potato.pets
  end

  def show
    # TODO: set up data for show view
    @pet = Pet.find_by_id(params[:id])
  end

  # TODO: set up *new* method with data for new view
  def new
    owner_id_from_url = params[:owner_id]
    @owner = Owner.find_by_id(owner_id_from_url)
    @pet = Pet.new
  end
  # TODO: set up *create* method with database interactions for create
  def create
    # look up owner
    owner_id_from_url = params[:owner_id]
    owner = Owner.find_by_id(owner_id_from_url)
    # get pet information - already done with pet_params
    # make a new pet with information
    new_pet = Pet.new(pet_params)
    # associate new pet with owner
    new_pet.owner = owner
    # save new pet
    new_pet.save
    # redirect to new pet's show page
    redirect_to pet_path(new_pet)
  end
  # TODO: handle save errors and communicate issues to user

  private
  def pet_params
    params.require(:pet).permit(:name, :breed, :date_of_birth)
  end

end
