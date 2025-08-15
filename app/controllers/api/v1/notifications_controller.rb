class Api::V1::NotificationsController < ApplicationController

  def index
    notifications = Notification.only_for(current_user.id).unread
    render json: { notifications: notifications.as_json(only: [:id, :title, :message, :created_at]) }
  end

  def show
    notification = Notification.find(params[:id])
    render json: { notification: notification.as_json(only: [:id, :hired_by_id, :title, :message, :created_at]) }
  end

end
