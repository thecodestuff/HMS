# frozen_string_literal: true

module Admin
  # Handle patients operation
  class PatientsController < ApplicationController
    before_action :find_patient, only: %i[update destroy ]
    before_action :check_billing_status, only: %i[update]

    def new
      @patient = Patient.new
    end

    def create
      @patient = Patient.new(patient_params)
      @patient.save
      message = @patient.errors.any? ? @patient.errors[:base][0] : 'Patient admitted'
      respond_to do |format|
        format.html { redirect admin_manage_patient_path, message }
      end
    end

    def patients
      @patient = Patient.new
      @patients = Patient.joins('INNER JOIN ward_occupancy_details w ON patients.ward_occupancy_detail_id = w.id')
                         .joins('INNER JOIN users u ON u.id = patients.user_id')
                         .select('patients.*,u.firstname, w.ward_name')
                         .page(params[:page]).per(5)
    end

    def update
      message = @patient.errors[:base][0]
      if @patient.errors.none?
        @patient.update(status: 'discharged')
        message = 'Patient discharged successflly'
      end

      respond_to do |format|
        format.html { redirect admin_manage_patient_path, message }
      end
    end

    def destroy
      respond_to do |format|
        format.js if @patient.destroy
      end
    end

    # This function  removed as part of re-factor , to use apply as before_action
    # def update_discharge_date
    #   @patient.update(dischagre_on: Date.current) if @patient.dischagre_on.nil?
    #   respond_to do |format|
    #     format.html { redirect admin_manage_patient_path, 'Patient checkout' }
    #     format.js
    #   end
    # end
    

    private

    def patient_params
      params.require(:patient).permit(
        :id,
        :user_id,
        :patient_type,
        :ward_assigned,
        :admit_date,
        :discharge_on,
        :status,
        :ward_occupancy_detail_id
      )
    end

    def find_patient
      @patient = Patient.find(params[:id]) if params[:id].present?
    end

    def check_billing_status
      if @patient.invoice.present?
        @patient.errors.add(:base, 'Patient Bill not paid yet') if @patient.invoice.pending?
      else
        @patient.errors.add(:base, 'Patient Bill not generated yet')
      end
    end
  end
end
