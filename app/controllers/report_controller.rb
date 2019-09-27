class ReportController < Admin::AdminController
  def generate_appointment_report
    Appointment.group(:appointment_date).count
  end
end
