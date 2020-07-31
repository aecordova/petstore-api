class Api::V1::PetsController < ApplicationController
  def index
    pets = orchestrate_query(Pet.all)
    render json: pets
  end
  
  def show

  end

  def create
    if pet.save
      render json: pet
    else
      unprocessable_entity!(pet)
    end
  end

  private

  def pet
    @pet ||= params[:id] ? Pet.find_by!(id: params[:id]) : Pet.new(pet_params)
  end
  
  def pet_params
    params.require(:pet).permit(:name, :tag)
  end

end
