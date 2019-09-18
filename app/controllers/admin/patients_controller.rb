# frozen_string_literal: true

module Admin
  # Handle patients operation
  class PatientsController < ApplicationController
    before_action :find_patient, only: %i[update destroy billing update_discharge_date]
    before_action :check_billing_status, only: %i[update]

    def new
      @patient = Patient.new
    end

    def create
      @patient = Patient.new(patient_params)
      respond_to do |format|
        message = 'Patient admitted'
        message = 'Patient already admitted' unless @patient.save
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
      respond_to do |format|
        @patient.update(status: 'discharged') if @patient.status != 'discharged'
        format.html { redirect admin_manage_patient_path, 'patient dischared success' }
        format.js
      end
    end

    def destroy
      respond_to do |format|
        format.js if @patient.destroy
      end
    end

    def update_discharge_date
      @patient.update(dischagre_on: Date.current) if @patient.dischagre_on.nil?
      respond_to do |format|
        format.html { redirect admin_manage_patient_path, 'Patient checkout' }
        format.js
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
        :status,
        :ward_occupancy_detail_id
      )
    end

    def find_patient
      @patient = Patient.find(params[:id]) if params[:id].present?
    end

    def check_billing_status
      unless @patient.invoice.present? & @patient.invoice.paid?
        redirect admin_manage_patient_path, 'Patient Not Billed Yet'
      end
    end
  end
end
