# frozen_string_literal: true

# Rules for validations, associatoin for patients table
class Patient < ApplicationRecord
  enum patient_type: %i[out_patient in_patient emergency]
  enum status: %i[not_admit admit refered discharged checkout]

  #validate :status_cannot_be_dischared_on_creating

  before_create :dump_admit_date
  before_update :dump_admit_date
  after_create :update_ward_status
  after_update :update_ward_status

  belongs_to :user
  belongs_to :ward_occupancy_detail
  has_one :invoice, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :physicians, through: :appointments

  validates_uniqueness_of :user_id

  scope :not_admit, -> { includes(:user).map { |patient| [patient.user.firstname, patient.user.id]} }
  scope :list, -> {
    joins('INNER JOIN ward_occupancy_details w ON patients.ward_occupancy_detail_id = w.id')
      .joins('INNER JOIN users u ON u.id = patients.user_id')
      .select('patients.*,u.firstname, w.ward_name')
      .order(admit_date: :desc)
  }

  def dump_admit_date
    self.admit_date = Date.current unless admit_date.present?
  end

  def update_ward_status
    ward_occupancy_detail.update(status: 'not_empty') if status == 'admit'
    ward_occupancy_detail.update(status: 'empty') if status == 'discharged'
  end

  def self.find_or_create_patient(patient_params)
    where(user_id: patient_params[:user_id]).first_or_create do |patient|
      patient.update_attributes(patient_params)
    end
  end

  # def status_cannot_be_dischared_on_creating
  #   errors.add(:base, 'Patient not admit') if discharged?
  # end
end
