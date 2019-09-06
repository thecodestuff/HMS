module Admin::PatientsHelper
  def fetch_patient_name_from_user_id(id)
    User.patient.firstname
  end
end
