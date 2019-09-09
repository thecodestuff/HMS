class Appointment < ApplicationRecord
  belongs_to :physician
  belongs_to :patient

  enum status: %i[pending done]

  validates :physician_id, :patient_id, :appointment_date , presence:true
  validate :appointment_date_cannot_be_in_past

  scope :today_appointment, ->(id) { where(physician_id: id, appointment_date: Date.current) }
  scope :pending_appointment, ->(id) { where(status: "pending", physician_id: id, appointment_date: Date.current) }

  def appointment_date_cannot_be_in_past
    errors.add(:appointment_date, 'Appointment date cannot be in past') unless appointment_date.day >= Date.current.day
  end
end
