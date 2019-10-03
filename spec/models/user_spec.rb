require 'rails_helper'
require 'factories/user'

RSpec.describe User, type: :model do 

  def build_and_validate_user
    user = build(:user)
    user.validate!
    user
  end

  it 'should create user successully with fixture data' do 
    user = build_and_validate_user
    expect(user).to be_valid
  end
end
