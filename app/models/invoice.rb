class Invoice < ApplicationRecord
  enum status: %i[pending paid]
  belongs_to :patient

  validates_uniqueness_of :patient_id
end
