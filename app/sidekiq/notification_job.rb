class NotificationJob
  include Sidekiq::Job

  def perform(tirador_id, title, service_request, client_name, client_mobile)
    tirador = User.find(tirador_id)
    
    # Send email
    TiradorMailer.new_hiring_request(tirador, service_request, client_name, client_mobile).deliver_later
  end
end

