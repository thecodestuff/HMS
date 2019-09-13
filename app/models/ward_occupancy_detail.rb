class WardOccupancyDetail < ApplicationRecord
  has_one :patient

  enum status: %i[empty not_empty]
  enum ward_type: %i[GEN DEX GOLD]

  validates :ward_name, :ward_type, presence: true
  validates_uniqueness_of :ward_name

  scope :wards, -> { count }
  scope :empty, -> { where(status: :empty) }
end
