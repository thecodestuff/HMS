class Admin::AppointmentsController < ApplicationController
  def index
    #@records = Appointment.all 
    #render html: get_patient_name.to_s
  end

  def new
    @appointment = Appointment.new 
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save 
      flash[:notice] = 'appointment scheduled successfuly..'
      redirect_to admin_appointments_path
    else 
      flash[:notice] = 'oops something wrong...'
      redirect_to new_admin_appointment_path
    end
  end

  def destroy
    if Appointment.delete(params[:id])
      flash[:notice] = "deleted successfully.."
      redirect_to admin_appointments_path
    end
  end

  private 

  def appointment_params
    params.require(:appointment).permit(:patient_id, :physician_id)
  end
end
