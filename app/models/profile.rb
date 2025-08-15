class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :photo
  
  has_one :more_info

  validate :acceptable_image

  validates :last_name, :first_name, :birth_date, :sex,
            :province, :town, :barangay, :street,
            presence: true

  # Length validations (optional, adjust as needed)
  validates :last_name, :first_name, :middle_name, length: { maximum: 50 }

  # Inclusion validation for sex
  validates :sex, inclusion: { in: ['Male', 'Female'], message: "%{value} is not a valid gender" }

  # Custom validation example (optional)
  validate :birth_date_cannot_be_in_the_future

  scope :exclude_me, ->(current_user_id) { where.not(user_id: current_user_id) }

  scope :tiradors, ->(service_title) {
    includes(:more_info).where(more_infos: { active_service: service_title })
  }

  def photo_url
    Rails.application.routes.url_helpers.url_for(photo) if photo.attached?
  end

  private

  def acceptable_image
    return unless photo.attached?

    # Validate file size (5MB limit)
    if photo.blob.byte_size > 5.megabytes
      errors.add(:photo, "is too large. Maximum size is 5MB.")
    end

    # Validate content type
    unless photo.content_type.in?(%w(image/jpeg image/png))
      errors.add(:photo, "must be a JPG or PNG file.")
    end
  end  

  def birth_date_cannot_be_in_the_future
    if birth_date.present? && birth_date > Date.today
      errors.add(:birth_date, "can't be in the future")
    end
  end

end
