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

  devise :database_authenticatable, :recoverable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: %i[github facebook google_oauth2]

  scope :by_role, ->(role) { where(role: role) }
  scope :is_admit, -> { includes(:patient).where(role: 'Patient').map { |user| [user.firstname, user.id ] } }

  def humanize_name
    self.firstname = firstname.humanize
    self.lastname = lastname.humanize
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 10]
      user.firstname, user.lastname = auth.info.name.split(' ')   # assuming the user model has a name
      user.lastname = "not found" if user.lastname.nil?
      user.civil_id = '0000000000'
      user.phone = '9878765678'
      user.role ='Physician'

      user.token = auth.credentials.token
      user.expires = auth.credentials.expires
      user.expires_at = auth.credentials.expires_at
      user.refresh_token = auth.credentials.refresh_token
      #user.avatar = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
