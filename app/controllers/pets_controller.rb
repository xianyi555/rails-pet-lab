class PetsController < ApplicationController

  def index
    # TODO: set up data for index view
  end

  def show
    # TODO: set up data for show view
  end

  # TODO: set up *new* method with data for new view

  # TODO: set up *create* method with database interactions for create
  # TODO: handle save errors and communicate issues to user

  private
  def pet_params
    params.require(:pet).permit(:name, :breed, :date_of_birth)
  end

end
