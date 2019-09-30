# Physician Model class
class Physician < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates_uniqueness_of :user_id

  # scope for api
  scope :appointments_data, -> {
    joins(:appointments)
      .joins('INNER JOIN users u ON physicians.user_id = u.id')
      .select(:id, :user_id, :charge, :patient_id, :firstname)
  }
end
