class Notification < ApplicationRecord
  belongs_to :tirador, class_name: "User", foreign_key: "tirador_id"
  belongs_to :hired_by, class_name: "User", foreign_key: "hired_by_id"

  after_create_commit :broadcast_to_tirador

  scope :only_for, ->(user_id) { where('tirador_id = ?', user_id) }
  
  scope :unread, -> { where(read: false) }

  private

  def broadcast_to_tirador
    ActionCable.server.broadcast(
      "notifications_#{tirador.id}",
      {
        notification_id: id.to_s,
        tirador_id: tirador.id.to_s,
        unread_count: Notification.only_for(tirador.id).unread.count,
        title: title,
        message: message,
      }
    )
  end
end