class User < ApplicationRecord
  # This line adds the ability to generate and regenerate the API token.
  # It requires an 'api_token' column.
  has_secure_token :api_token
  
  has_one :profile, dependent: :destroy

  # --- Validations ---
  # These are application-level rules that are checked before saving a user.

  PHILIPPINE_MOBILE_NUMBER_REGEX = /\A09\d{9}\z/

  # Ensures a mobile_number is always present.
  validates :mobile_number, presence: true,
            format: { with: PHILIPPINE_MOBILE_NUMBER_REGEX, message: 'must be a valid Philippine mobile number' },
            uniqueness: { case_sensitive: false }
  # Ensures email is present, unique (case-insensitive), and in a valid format.
  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  # Ensures a mobile_number and username are always present.
  validates :username, presence: true

  # Ensures the API token is unique.
  validates :api_token, uniqueness: true

  # has_secure_password adds its own password presence validation,
  # but we can add a length requirement for better security.
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  # This line adds all the password hashing and authentication logic.
  # It requires the 'bcrypt' gem and a 'password_digest' column.
  has_secure_password

  has_one :profile, dependent: :destroy

end
