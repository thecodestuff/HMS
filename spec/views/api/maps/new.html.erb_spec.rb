require 'rails_helper'

RSpec.describe "api/maps/new", type: :view do
  before(:each) do
    assign(:api_map, Api::Map.new(
      :name => "MyString",
      :lat => "9.99",
      :long => "9.99"
    ))
  end

  it "renders new api_map form" do
    render

    assert_select "form[action=?][method=?]", api_maps_path, "post" do

      assert_select "input[name=?]", "api_map[name]"

      assert_select "input[name=?]", "api_map[lat]"

      assert_select "input[name=?]", "api_map[long]"
    end
  end
end
