class Patient < ApplicationRecord
  enum patient_type: %i[out_patient in_patient emergency]
  enum status: %i[not_admit admit refered discharged]

  before_create :dump_admit_date
  after_create :update_ward_status
  after_update :update_ward_status
  before_update :dump_discharge_date

  belongs_to :user
  belongs_to :ward_occupancy_detail
  has_many :appointments, dependent: :destroy
  has_many :physicians, through: :appointments

  validates_uniqueness_of :user_id

  def dump_admit_date
    self.admit_date = Date.current unless self.admit_date.present?
  end

  def dump_discharge_date
    self.dischagre_on = Date.current unless self.dischagre_on.present?
  end

  def update_ward_status
      self.ward_occupancy_detail.update(status: 'not_empty') if self.status == 'admit'
      self.ward_occupancy_detail.update(status: 'empty') if self.status == 'discharged'
  end
end
