class Patient < ApplicationRecord
  enum patient_type: [:outpatient, :inpatient, :emergency]
  belongs_to :user
  has_many :appointments
  has_many :physicians, through: :appointments 
end
