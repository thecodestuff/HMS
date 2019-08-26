class Patient < ApplicationRecord
  self.primary_key = 'patient_id'
  belongs_to :user

  has_many :appointments
  has_many :physicians, through: :appointments 
end
