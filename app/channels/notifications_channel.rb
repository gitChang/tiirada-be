class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # You can scope by current_user if you want per-user streams
    stream_from "notifications_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed
  end
end
