# frozen_string_literal: true

module Admin
  # Handle patients operation
  class PatientsController < ApplicationController

    def new
      @patient = Patient.new
    end

    def create
      @patient = Patient.new(patient_params)
      respond_to do |format|
        message = 'Patient already admitted' unless @patient.save
        message = 'Patient admitted'
        format.html { redirect new_admin_patient_path, message }
      end
    end

    def patients
      #@patients = Patient.all.page(params[:page]).per(1)
      @patients = Patient.joins('INNER JOIN ward_occupancy_details w ON patients.ward_occupancy_detail_id = w.id')
                         .joins('INNER JOIN users u ON u.id = patients.user_id')
                         .select('patients.*,u.firstname, w.ward_name')
                         .page(params[:page]).per(5)
    end

    def update
      @patient = Patient.find(params[:id])
      respond_to do |format|
        @patient.update(status: 'discharged') if @patient.status != 'discharged'
        format.html { redirect admin_discharge_path, 'patient dischared success' }
        format.js
      end
    end

    def destroy
      # byebug
      patient = Patient.find(params[:id])
      respond_to do |format|
        format.js if patient.destroy
      end
    end

    def billing
      patient = Patient.find(params[:id]) if params[:id].present?
      no_of_appointments = patient.appointments.count
      no_of_day_in_ward = patient.dischagre_on.day - patient.admit_date.day
      render html: "#Number of appointmetns = #{no_of_appointments}*RATE + #{no_of_day_in_ward}*RATES = Bill amount"
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

    def update_ward_status
      if params[:user_id].present?
        byebug
        ward = WardOccupancyDetail.where(ward_name: Patient.find(params[:user_id]).ward_assigned)
        ward.first.update(status: :foo)
      end
    end
  end
end
