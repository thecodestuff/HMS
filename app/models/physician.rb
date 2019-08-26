class Physician < ApplicationRecord
  self.primary_key = 'physician_id'
  belongs_to :user

  has_many :appointments
  has_many :patients, through: :appointments 
end
