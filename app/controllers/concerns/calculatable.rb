# Use to calculate different billing entites that are required to 
# to create invoice

module Calculatable
  extend ActiveSupport::Concern
  def calculate_bill(patient)
    calculate_days(patient) * ward_rate(patient) + calculate_appointments_charges(patient)
  end

  def calculate_days(patient)
    days = (patient.dischagre_on.day - patient.admit_date.day).abs
    days.zero? ? 1 : days
  end

  def calculate_appointments(patient)
    patient.appointments
           .where('appointment_date > :date and status = :status', date: patient.dischagre_on, status:1)
           .count
  end

  def calculate_appointments_charges(patient)
    appointments = patient.appointments.done
                          .joins(:physician)
                          .select(:appointment_date, :charge, :charge_at_weekend)

    appointments.collect do |attr|
      attr.appointment_date.on_weekend? ? attr.charge_at_weekend.to_i : attr.charge.to_i
    end.sum
  end

  def ward_rate(patient)
    Invoice.rate[patient.ward_occupancy_detail.ward_type.to_sym]
  end
end
