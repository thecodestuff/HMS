class Appointment < ApplicationRecord
  enum patient_type: %i[pending done]
  belongs_to :physician
  belongs_to :patient
end
