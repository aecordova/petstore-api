require "rails_helper"

RSpec.describe Api::V1::PetsController, type: :controller do
  describe "routes" do
    it { should route(:get, "api/v1/pets").to(action: :index) }
    it { should route(:get, "api/v1/pets/1").to(action: :show, id: 1) }
    it { should route(:post, "api/v1/pets").to(action: :create) }
  end

  describe "rescue from errors" do
    it { should rescue_from ActiveRecord::RecordNotFound }
  end
end

RSpec.describe "PetsRequests", type: :request do
  describe "GET #index" do
    it "should get index" do
      get api_v1_pets_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST pets#create" do
    it "create a pet record  with valid attributes" do
      pet_params = {
        pet: {
          name: "John",
          tag: "Doe",
        },
      }
      post api_v1_pets_path, :params => pet_params.to_json, :headers => { "Content-Type": "application/json" }
      expect(response).to have_http_status(201)
    end
  end
  
  describe "POST pets#show" do
    pet1 = Pet.create(name: 'misty')
    it "shows a specific pet record with a valid id" do
      params = { id: pet1.id }
      get api_v1_pet_path(params)
      response_body = JSON.parse(response.body)
      expect(response_body['name']).to match(pet1.name)
    end
  end
end
