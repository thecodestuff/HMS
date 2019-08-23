class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  scope :is_admin , ->{ where(admin: true).count }
  scope :is_doctor, ->{ where(role: 'doctor').count }
  scope :is_nurse, ->{ where(role: 'nurse').count }
  scope :is_patient, ->{ where(role: 'patient').count }
end
