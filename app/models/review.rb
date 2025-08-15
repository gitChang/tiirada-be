class Review < ApplicationRecord
  # If tirador is actually a User, you can still associate manually:
  belongs_to :tirador, class_name: "User", foreign_key: "tirador_id"

  belongs_to :client, class_name: "User", foreign_key: "client_id"
end
