class Admin::AppointmentsController < ApplicationController
  def index
    @appointment = Appointment.new
    respond_to do |format|
      format.html { @appointments = fetch_records }
    end
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params)
    respond_to do |format|
      if @appointment.save
        format.js do
          flash.now[:notice] = 'appointment scheduled successfuly..'
        end
      else
        flash[:notice] = @appointment.errors.details.to_s
        redirect_to new_admin_appointment_path
      end
    end
  end

  def destroy
    respond_to do |format|
      format.js if Appointment.delete(params[:id])
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    respond_to do |format|
      @appointment.update(status: 1)
      @appointment.save if @appointment.valid?
      format.js
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id, :physician_id, :appointment_date, :status)
  end

  def fetch_records
    record_array = []
    if current_user.admin?
      @appointments = Appointment.all
    else
      @appointments = Appointment.where(physician_id: current_user.physician)
    end 

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
end
