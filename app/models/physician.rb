# Physician Model class
class Physician < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  validates_uniqueness_of :user_id
end
