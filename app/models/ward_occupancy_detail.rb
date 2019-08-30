class WardOccupancyDetail < ApplicationRecord
  enum status: %i[EMPTY NOTEMPTY]
  enum ward_type: %i[GEN DEX GOLD]
  scope :wards, -> { count }
  scope :status, -> { where(status: 0) }
end
