class PetsController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

  def show
  end


  private
  def pet_params
    params.require(:pet).permit(:name, :breed, :date_of_birth)
  end

end
