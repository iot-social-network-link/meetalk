require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #room" do
    it "returns http success" do
      get :room
      expect(response).to have_http_status(:success)
    end
  end

end
