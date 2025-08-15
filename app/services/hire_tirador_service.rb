class HireTiradorService
  def initialize(client, service_request, tirador_id)  
    @client = client.profile
    @service_request = service_request
    @tirador_id = tirador_id

    @title = "New Service Request: #{@service_request}"
    @client_full_name = "#{@client.first_name} #{@client.last_name}"
  end

  def call
    hiring = Hiring.create(
      hired_by_id: @client.user_id,
      service_request: @service_request,
      tirador_id: @tirador_id,
    )

    # Save in Notification
    notified = Notification.create(
      tirador_id: @tirador_id, 
      hired_by_id: @client.user_id,
      title: @title, 
      message: "Your client #{@client_full_name} is in need of #{@service_request} service."
    )

    if hiring.persisted? && notified.persisted?
      NotificationJob.perform_async(
        @tirador_id, 
        @title, 
        @service_request, 
        @client_full_name, 
        @client.user.mobile_number
      )
    end

    hiring
  end
end
