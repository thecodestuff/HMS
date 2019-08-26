class Admin::PatientsController < ApplicationController

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    respond_to do |format|
      if @patient.save
        format.html{redirect_to new_admin_patient_path, notice:'patient admited...'}
      else 
        format.html{redirect_to new_admin_patient_path, notice:"#{@patient.errors.details}"}
      end
    end
  end

  private 
  def patient_params
    params.require(:patient).permit(
      :id,
      :user_id, 
      :patient_type,
      :ward_assigned,
      :status 
    )
  end
end
