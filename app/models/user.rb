class User < ApplicationRecord
  enum role: %i[patient admin physician nurse]

  has_one :patient, dependent: :destroy
  has_one :physician, dependent: :destroy
  has_one_attached :avatar

  validates :firstname, :lastname, :department, :phone, :role, presence: true
  validates :civil_id, length: { is: 10 }
  validates :password, length: { in: 6..10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  scope :is_admin,     -> { where(admin: true) }
  scope :is_nurse,     -> { where(role: :nurse) }
  scope :is_physician, -> { where(role: :physician) }
  scope :is_patients,  -> { where(role: :patient) }
  scope :by_role,  -> { where(role: role) } 
end
