RSpec.describe WardOccupancyDetail, type: :model do
  let(:ward_occupancy_detail) { create(:ward_occupancy_detail) }

  context 'validations' do
    it {  is_expected.to validate_uniqueness_of(:ward_name) }
  end
end