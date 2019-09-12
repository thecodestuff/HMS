module Admin::AppointmentsHelper
  def get_physician_names
    User.is_physician.collect do |user| 
      [user.firstname, user.physician.id] if user.physician.present? 
    end.compact
  end

  def get_patient_names
    User.is_patients.collect do |user|
      [user.firstname, user.patient.id] if user.patient.present? 
    end.compact
  end
end
