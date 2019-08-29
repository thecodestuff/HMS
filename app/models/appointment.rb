class Appointment < ApplicationRecord
  enum patient_type: %i[pending done]
  belongs_to :physician
  belongs_to :patient
  scope :today_appointment, ->(id){ where(physician_id: id, appointment_date: Date.current) }
  scope :pending_appointment, ->(id){ where(status: 0, physician_id: id, appointment_date: Date.current) }
end
