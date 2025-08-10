class Hiring < ApplicationRecord
  # If tirador is actually a User, you can still associate manually:
  belongs_to :tirador, class_name: "User", foreign_key: "tirador_id"
  belongs_to :hired_by, class_name: "User", foreign_key: "hired_by_id"
end
