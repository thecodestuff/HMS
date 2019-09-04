class Appointment < ApplicationRecord
  enum status: %i[pending done]
  belongs_to :physician
  belongs_to :patient
  scope :today_appointment, ->(id) { where(physician_id: id, appointment_date: Date.current) }
  scope :pending_appointment, ->(id) { where(status: 0, physician_id: id, appointment_date: Date.current) }

  validates :physician_id, :patient_id, :appointment_date , presence:true
  validate :appointment_date_cannot_be_in_past

  def appointment_date_cannot_be_in_past
    errors.add(:appointment_date, 'appointment date cannot be in past') unless appointment_date.day >= Date.current.day
  end
end
