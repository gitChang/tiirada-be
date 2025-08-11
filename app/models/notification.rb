class Notification < ApplicationRecord
  after_create_commit :broadcast
  
  belongs_to :user

  private

  def broadcast
    ActionCable.server.broadcast(
      "notifications_#{user.id}",
      {
        id: id,
        unread_count: user.notifications.where(read: false).count
      }
    )
  end
end

