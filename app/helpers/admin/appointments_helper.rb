module Admin::AppointmentsHelper
  def fetch_records
    record_array = []
    @appointments = Appointment.all

    @appointments.each do |appointment|
      record_array << [
        appointment.id, get_patient_name(appointment.patient),
        get_physician_name(appointment.physician)
      ]
    end
    record_array
  end

  def get_patient_name(patient)
    patient = Patient.find(patient.id)
    user = User.find(patient.user_id)
    user.firstname
  end

  def get_physician_name(physician)
    physician = Physician.find(physician.id)
    user = User.find(physician.user_id)
    user.firstname
  end
end
