require 'rails_helper'
require 'factories/user2'
require 'factories/ward_occupancy_detail'
require 'factories/patient'

RSpec.describe Admin::PatientsController, type: :controller do
  login_admin

  it 'should have a current  user' do
    expect(subject.current_user).to_not eql(nil)
  end

  describe 'GET #new' do
    it 'should render view' do
      get 'new'
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:valid_user) }
    let(:ward) { FactoryBot.create(:ward_occupancy_detail) }
    let(:patient) { FactoryBot.create(:valid_patient, user_id: user.id, ward_occupancy_detail_id: ward.id) }

    context 'success' do 
      it 'should create new patient' do
        expect{
          #byebug
          post :create, params: {patient: FactoryBot.attributes_for(:valid_patient)}
        }.to change(Patient, :count).by(1)
      end
    end
  end
end