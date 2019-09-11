class Patient < ApplicationRecord
  enum patient_type: %i[out_patient in_patient emergency]
  enum status: %i[not_admit admit refered discharged]

  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :physicians, through: :appointments

  validates_uniqueness_of :user_id
end
