class V1::PetsController < ApplicationController
  PAGE_SIZE = 100

  def index
    pets = orchestrate_query(Pet.all)
    render serialize(pets)
  end
  
  def show
    render serialize(pet)
  end

  def create
    if pet.save
      render serialize(pet)
    else
      unprocessable_entity!(pet)
    end
  end

  private

  def pet
    @pet ||= params[:id] ? Pet.find_by!(id: params[:id]) : Pet.new(pet_params)
  end
  
  def pet_params
    params.require(:data).permit(:name, :tag)
  end
end
