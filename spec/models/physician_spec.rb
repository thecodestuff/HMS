require 'rails_helper'
require 'factories/physician'
require 'factories/physician'

RSpec.describe Physician, type: :model do
  let(:user) { create(:user) }
  let!(:physician) { create(:physician, user_id: user.id ) }

  context 'physician validations' do
    it { is_expected.to validate_uniqueness_of(:user_id) }
  end

  context 'physician association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:appointments) }
    it { is_expected.to have_many(:patients) }
  end

  context 'physician attributes validity' do
    it 'physician charge should be positive' do
      expect(physician.charge).to be > 0
      expect(physician.charge_at_weekend).to be > 0
    end
  end
end
