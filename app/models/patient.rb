class Patient < ApplicationRecord
  enum patient_type: %i[outpatient inpatient emergency]
  enum status: %i[notadmit admit refered]
  belongs_to :user
  has_many :appointments
  has_many :physicians, through: :appointments

  validates_uniqueness_of :user_id
end
