class Invoice < ApplicationRecord
  enum status: %i[pending paid]
  belongs_to :patient

  validates_uniqueness_of :patient_id

  before_create :cannot_create_invoice_if_patient_discharged

  scope :patient_name, -> {
    Invoice.joins(:patient)
           .joins('INNER JOIN users u ON patients.user_id = u.id')
           .select(
             'invoices.id,
             invoices.status,
             invoices.patient_id,
             invoices.amount,
             u.firstname'
           )
  }

  def self.rate
    { 'GEN': 100, 'DEX': 200 }
  end

  def cannot_create_invoice_if_patient_discharged
    errors[:base] << 'invoice already generated' if patient.discharged?
  end
end
