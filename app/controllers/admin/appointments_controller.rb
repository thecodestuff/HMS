# frozen_string_literal: true

module Admin
  # Appointment actions
  class AppointmentsController < ApplicationController
    before_action :new_appointment
    before_action :find_appointment, only: %i[cancel_appointment]
    before_action :cannot_cancel_appointment_if_done, only: %i[cancel_appointment]

    def index
      @appointments = paginate(fetch_records)
      respond_to do |format|
        format.html { @appointments }
      end
    end

    def create
      @appointment = Appointment.new(appointment_params)
      respond_to do |format|
        flash[:notice] = 'Operation failed' unless @appointment.save
        format.html { redirect_to new_admin_appointment_path }
        format.js { @appointment = fetch_records }
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

    def cancel_appointment
      message = @appointment.errors.any? ? @appointment.errors[:base][0] : 'Appointment cancelled'
      @appointment.update(status: 'canceled') unless @appointment.done?
      respond_to do |format|
        format.html { redirect admin_appointments_path, message }
        format.js { destroy.js }
      end
    end

    def calender
      @appointments = Appointment.all
    end

    private

    def appointment_params
      params.require(:appointment).permit(
        :patient_id, :physician_id, :appointment_date, :status
        )
    end

    def fetch_records
      @appointments = current_user.admin? ? Appointment.includes(:patient, :physician).all : Appointment.current_user(current_user.physician)
      @appointments.collect do |appointment|
        [
          appointment.id, appointment.patient.user.firstname,
          appointment.physician.user.firstname, appointment.status,
          appointment.appointment_date
        ]
      end
    end

    def paginate(appointments)
      @paginate_appointments = Kaminari.paginate_array(appointments)
                                       .page(params[:page]).per(4)
    end

    def new_appointment
      @appointment = Appointment.new
    end

    def find_appointment
      @appointment = Appointment.find(params[:id])
    end

    def cannot_cancel_appointment_if_done
      @appointment.errors[:base] << 'Cannot cancel appointment' if @appointment.done?
    end
  end
end
