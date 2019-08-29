class Admin::AppointmentsController < ApplicationController
  def index; end

  def new
    @appointment = Appointment.new 
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:notice] = 'appointment scheduled successfuly..'
      redirect_to admin_appointments_path
    else
      flash[:notice] = @appointment.errors.details.to_s
      redirect_to new_admin_appointment_path
    end
  end

  def destroy
    respond_to do |format|
      if Appointment.delete(params[:id])
         format.js
        #flash[:notice] = 'deleted successfully..'
        #redirect_to admin_appointments_path
      end
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(status: 1)
    @appointment.save if @appointment.valid?
    flash[:notice] = 'appointment updated successfully'
    redirect_to admin_appointments_path
  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id, :physician_id, :appointment_date, :status)
  end
end
