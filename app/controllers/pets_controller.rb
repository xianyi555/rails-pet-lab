class PetsController < ApplicationController

  def index
    # TODO: set up data for index view
    @owner = Owner.find_by_id(params[:owner_id])
    @pet = Pet.all

  end

  def show
    @pet = Pet.find_by_id(params[:id])
    # TODO: set up data for show view
  end

  # TODO: set up *new* method with data for new view
  def new
    @pet = Pet.new
  end

  # TODO: set up *create* method with database interactions for create
  def create
    @owner = Owner.find_by_id(params[:owner_id])
    @pet = @owner.pets.new(pet_params)
    @pet.save

    redirect_to (pet_path(@pet))
  end
  # TODO: handle save errors and communicate issues to user

  private
  def pet_params
    params.require(:pet).permit(:name, :breed, :date_of_birth)
  end

end
