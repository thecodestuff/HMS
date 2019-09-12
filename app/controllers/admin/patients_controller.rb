class Admin::PatientsController < ApplicationController
  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    respond_to do |format|
      @patient.save ? redirect(format, 'patient admitted...') : redirect(format, 'patient already admitted')
    end
    update_ward_status(@patient.id, 1)
  end

  def patients
    @patients = Patient.page(params[:page]).per(5)
  end

  def update
    @patient = Patient.find(params[:id])
    respond_to do |format|
      @patient.update(status: 'discharged') if @patient.status != 'discharged'
      format.html { redirect_to admin_discharge_path, flash[:notice]='patient dischared success' }
      format.js
    end
  end

  def destroy
    update_ward_status(params[:id],0)
    respond_to do |format|
      format.js if Patient.destroy(params[:id])
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

  def update_ward_status(id, flag)
    if id.present?
      ward = WardOccupancyDetail.where(ward_name: Patient.find(id).ward_assigned)
      ward.first.update(status: flag)
    end
  end

  def redirect(format, message)
    format.html { redirect_to new_admin_patient_path, notice: message }
  end
end
