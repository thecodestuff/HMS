class User < ApplicationRecord
  enum role: %i[Patient Admin Physician Nurse]
  before_save :humanize_name

  has_one :patient, dependent: :destroy
  has_one :physician, dependent: :destroy
  has_one_attached :avatar

  validates :firstname, :lastname, :department, :phone, :role, presence: true
  validates :civil_id, length: { is: 10 }
  validates :password, length: { in: 6..10 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  scope :is_admin,     -> { where(role: :Admin) }
  scope :is_nurse,     -> { where(role: :Nurse) }
  scope :is_physician, -> { where(role: :Physician) }
  scope :is_patients,  -> { where(role: :Patient) }
  scope :by_role, -> { where(role: role) }

  def humanize_name
    self.firstname = self.firstname.humanize
    self.lastname = self.lastname.humanize
  end
end
