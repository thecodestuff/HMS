require 'rails_helper'
require 'factories/patient'
require 'factories/ward_occupancy_detail'

RSpec.describe Patient do

  let(:user) { create(:user) }
  let(:ward_occupancy_detail) { create(:ward_occupancy_detail) }
  let(:patient) { create(:patient, user_id:user.id, ward_occupancy_detail_id:ward_occupancy_detail.id) }
 
  context 'patient model validations' do 
    # user = build_and_create_patient
    it { is_expected.to validate_uniqueness_of(:user_id) }
  end

  context 'patient associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:ward_occupancy_detail) }
    it { is_expected.to have_one(:invoice).dependent(:destroy) }
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
    it { is_expected.to have_many(:physicians) }
  end

  context 'patient callbacks test suit' do
    it 'should dump current date as admit date before patient created' do
      expect(patient.admit_date).to eq(Date.current)
    end

    it 'should update ward status to not empty if patient is admit' do
      patient.update(status:'admit')
      expect(patient.status).to eq('admit')
      expect(patient.ward_occupancy_detail.status).to eq('not_empty')
    end 

    it 'should update ward status to empty after patient dischrged' do
      patient.update(status: 'discharged')
      expect(patient.status).to eq('discharged')
      expect(patient.ward_occupancy_detail.status).to eq('empty')
    end
  end
end
