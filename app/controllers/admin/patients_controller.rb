class Admin::PatientsController < ApplicationController
  before_action :update_ward_status, only: %i[destroy]
  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    respond_to do |format|
      if @patient.save
        format.html { redirect_to new_admin_patient_path, notice: 'patient admited...' }
      else
        format.html { redirect_to new_admin_patient_path, alert: 'unprocessable entity....' }
      end
    end
  end

  def patients
    @patients = Patient.all
  end

  def destroy
    respond_to do |format|
      format.js if Patient.delete(params[:id])
    end
  end

  private

  def patient_params
    params.require(:patient).permit(
      :id,
      :user_id,
      :patient_type,
      :ward_assigned,
      :admit_date,
      :discharge_on,
      :status
    )
  end

  def update_ward_status
    ward = WardOccupancyDetail.where(ward_name: Patient.find(params[:id]).ward_assigned )
    ward.update(status: 0)
  end
end
