require 'rails_helper'

RSpec.describe "Api::Maps", type: :request do
  describe "GET /api/maps" do
    it "works! (now write some real specs)" do
      get api_maps_path
      expect(response).to have_http_status(200)
    end
  end
end
