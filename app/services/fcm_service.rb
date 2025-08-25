class FcmService
  def self.send_notification_to_user(user, notification_data)
    return unless user.fcm_token.present?

    message = {
      token: user.fcm_token,
      notification: {
        title: notification_data[:title],
        body: notification_data[:message]
      },
      data: {
        notification_id: notification_data[:id].to_s,
        title: notification_data[:title],
        message: notification_data[:message]
      }
    }

    response = Firebase::Messaging.send(message)
    Rails.logger.info("FCM response: #{response.result}")
  rescue => e
    Rails.logger.error("Failed to send FCM: #{e.message}")
  end
end
