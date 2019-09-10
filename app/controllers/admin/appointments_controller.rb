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
        @appointment = fetch_records
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
    @appointments = current_user.admin? ? Appointment.all : Appointment.current_user(current_user.physician)
    @appointments.collect do |appointment|
      [
        appointment.id,
        appointment.patient.user.firstname,
        appointment.physician.user.firstname,
        appointment.status,
        appointment.appointment_date
      ]
    end
  end
end
