class User < ApplicationRecord
  has_one :patient
  has_one :physician
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
         
  scope :is_admin , -> { where(admin: true).count }
  scope :is_doctor, -> { where(role: 'physician').count }
  scope :is_nurse, -> { where(role: 'nurse').count }
  scope :is_patient, -> { where(role: 'patient').count }

  scope :is_physician, ->{ where(role: 'physician') }
  scope :is_patients, ->{ where(role: 'general') }
end
