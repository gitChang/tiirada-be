class User < ApplicationRecord
  # This line adds the ability to generate and regenerate the API token.
  # It requires an 'api_token' column.
  has_secure_token :api_token
  
  has_one :profile, dependent: :destroy

  has_many :notifications, dependent: :destroy

  # The hirings where this user is the one who did the service
  has_many :service_requests, class_name: "Hiring", foreign_key: "tirador_id", dependent: :destroy

  # The hirings where this user is the one who did the hiring
  has_many :hirings, foreign_key: "hired_by_id", dependent: :destroy

  # This association gets all the reviews where this user is the 'tirador'
  has_many :reviews_as_tirador, class_name: "Review", foreign_key: "tirador_id", dependent: :destroy

  # This association gets all the reviews where this user is the 'client'
  has_many :reviews_as_client, class_name: "Review", foreign_key: "client_id", dependent: :destroy

  PHILIPPINE_MOBILE_NUMBER_REGEX = /\A09\d{9}\z/

  validates :mobile_number, presence: true,
            format: { with: PHILIPPINE_MOBILE_NUMBER_REGEX, message: 'must be a valid Philippine mobile number' },
            uniqueness: { case_sensitive: false }
  
  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :username, presence: true

  validates :api_token, uniqueness: true
  
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  has_secure_password

end
