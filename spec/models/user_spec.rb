require 'rails_helper'
require 'factories/user'

RSpec.describe User, type: :model do 

  def build_and_validate_user
    user = build(:user)
    user.validate!
    user
  end

  let(:user) { create(:user) }
  let(:patient) { create(:patient, user_id: user.id) }

  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
  it { is_expected.to validate_presence_of(:department) }
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_length_of(:civil_id).is_equal_to(10) }
  # it { is_expected.to allow_value(URI::MailTo::EMAIL_REGEXP).for(:email) }
  it { is_expected.to have_one(:patient).dependent(:destroy) }
  it { is_expected.to have_one(:physician).dependent(:destroy) }

  it 'should create user successully with fixture data' do 
    user = build_and_validate_user
    expect(user).to be_valid
  end

  context 'before persist' do
    it 'should humanzie firstname and lastname before persist' do
      user = build_and_validate_user
      user.save
      expect(user.firstname).to eql user.firstname.humanize
      expect(user.lastname).to eql user.lastname.humanize
    end
  end
end
