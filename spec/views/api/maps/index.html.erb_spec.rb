require 'rails_helper'

RSpec.describe "api/maps/index", type: :view do
  before(:each) do
    assign(:api_maps, [
      Api::Map.create!(
        :name => "Name",
        :lat => "9.99",
        :long => "9.99"
      ),
      Api::Map.create!(
        :name => "Name",
        :lat => "9.99",
        :long => "9.99"
      )
    ])
  end

  it "renders a list of api/maps" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
