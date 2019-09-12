class WardOccupancyDetail < ApplicationRecord
  enum status: %i[EMPTY NOTEMPTY]
  enum ward_type: %i[GEN DEX GOLD]

  validates :ward_name, :ward_type, presence: true
  validates_uniqueness_of :ward_name

  scope :wards, -> { count }
  scope :empty, -> { where(status: 'EMPTY') }
end
