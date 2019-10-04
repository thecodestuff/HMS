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

  scope :by_role, ->(role) { where(role: role) }
  scope :is_admit, -> { includes(:patient).where(role: 'Patient').map { |user| [user.firstname, user.id ] } }

  def humanize_name
    self.firstname = firstname.humanize
    self.lastname = lastname.humanize
  end
end
