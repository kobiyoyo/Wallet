class User < ApplicationRecord
  after_initialize :set_default_role, if: :new_record?

  # User Role
  ROLES = %i[noob elite admin].freeze
  enum role: ROLES

  # Relationship
  has_many :wallets
  has_many :transactions


  # Validations
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :role, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  # encrypt password
  has_secure_password
  validates :password_digest, presence: true, length: { minimum: 6 }

  # set new user role to customer
  def set_default_role
    self.role ||= :noob
  end

end
