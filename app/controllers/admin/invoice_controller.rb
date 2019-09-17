# frozen_string_literal: true

module Admin
  # create a invoice for patient
  class InvoiceController < ApplicationController
    before_action :invoice, only: [:create]
    before_action :find_invoice, only: [:update_status]

    def index
      @invoices = Invoice.page(params[:page]).per(2)
    end

    def create
      patient = Patient.find(params[:id])
      amount = calculate_bill patient
      @invoice.patient = patient
      @invoice.transactionId = SecureRandom.hex(10)
      @invoice.amount = amount
      flash[:notice] = 'failed to create invoice' unless @invoice.save
      flash[:notice] = 'invoice created success'
      redirect_to admin_manage_patient_path
    end

    def show
      respond_to do |format|
        format.html { render :show }
        format.pdf do
          render pdf: 'invoice.pdf',
                 template: 'admin/invoice/show.html.erb'
        end
      end
    end

    def update_status
      @patient_invoice.update(status: :paid) if @patient_invoice.status != 'paid'
      respond_to do |format|
        format.html { redirect admin_invoice_index_path, 'success' }
      end
    end

    private

    def invoice_params
      params.require(:invoice).permit(
        :id,
        :patient_id,
        :transactionId,
        :amount,
        :status
      )
    end

    def calculate_bill(patient)
      @total ||= (patient.dischagre_on.day - patient.admit_date.day) * 100
      + patient.appointments.count * 200
    end

    def invoice
      @invoice = Invoice.new
    end

    def find_invoice
      @patient_invoice = Invoice.find(params[:id])
    end
  end
end
