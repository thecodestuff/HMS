class Invoice < ApplicationRecord
  enum status: %i[pending paid]
  belongs_to :patient

  #validates_uniqueness_of :patient_id

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
end
