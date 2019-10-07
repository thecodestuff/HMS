require 'rails_helper'

RSpec.describe "api/maps/edit", type: :view do
  before(:each) do
    @api_map = assign(:api_map, Api::Map.create!(
      :name => "MyString",
      :lat => "9.99",
      :long => "9.99"
    ))
  end

  it "renders the edit api_map form" do
    render

    assert_select "form[action=?][method=?]", api_map_path(@api_map), "post" do

      assert_select "input[name=?]", "api_map[name]"

      assert_select "input[name=?]", "api_map[lat]"

      assert_select "input[name=?]", "api_map[long]"
    end
  end
end
