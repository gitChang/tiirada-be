class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  # Presence validations
  validates :last_name, :first_name, :birth_date, :sex,
            :province, :town, :barangay, :street,
            presence: true

  # Length validations (optional, adjust as needed)
  validates :last_name, :first_name, :middle_name, length: { maximum: 50 }

  # Inclusion validation for sex
  validates :sex, inclusion: { in: ['Male', 'Female'], message: "%{value} is not a valid gender" }

  # Custom validation example (optional)
  validate :birth_date_cannot_be_in_the_future


  def photo_url
    Rails.application.routes.url_helpers.url_for(photo) if photo.attached?
  end

  private

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "can't be in the future")
    end
  end

end
