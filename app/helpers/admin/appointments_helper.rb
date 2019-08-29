module Admin::AppointmentsHelper
  def fetch_records
    record_array = []
    @appointments = Appointment.all

    @appointments.each do |appointment|
      record_array << [
        appointment.id,
        get_patient_name(appointment.patient),
        get_physician_name(appointment.physician),
        appointment.appointment_date
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

  def get_physician_names
    user_array = []
    User.is_physician.each do |user|
      user_array << [
        user.firstname,
        Physician.where(user_id: user.id).map { |physician| physician }.first.id.to_i
      ]
    end
    user_array
  end

  def get_patient_names
    user_array = []
    User.is_patients.each do |user|
      user_array << [
        user.firstname,
        Patient.where(user_id: user.id).map { |patient| patient }.first.id.to_i
      ]
    end
    user_array
  end
end
