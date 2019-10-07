require 'rails_helper'

RSpec.describe "api/maps/show", type: :view do
  before(:each) do
    @api_map = assign(:api_map, Api::Map.create!(
      :name => "Name",
      :lat => "9.99",
      :long => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
