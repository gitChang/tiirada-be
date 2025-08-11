class Api::V1::NotificationsController < ApplicationController
  # GET /api/notifications/123
  def index
    notifications = Notification.where(user_id: params[:user_id]).order(created_at: :desc)
    render json: { notifications: notifications }
  end

end
