module Admin::AppointmentsHelper
  def get_physician_names
    User.is_physician.collect { |user| [user.firstname, user.physician.id] }
  end

  def get_patient_names
    User.is_patients.collect { |user| [user.firstname, user.patient.id] if user.patient.present? }.compact
  end
end
