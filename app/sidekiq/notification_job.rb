class NotificationJob
  include Sidekiq::Job

  def perform(tirador_id, title, service_title, client_name, client_mobile)
    # Find the tirador
    tirador = User.find(tirador_id)

    # Save in database
    Notification.create!(
      user: tirador, 
      title: title, 
      message: "Hired as #{service_title} from client: #{client_name} with contact no. #{client_mobile}."
    )

    # Send email
    TiradorMailer.new_hiring_request(tirador, client_name, client_mobile).deliver_later
  end
end

