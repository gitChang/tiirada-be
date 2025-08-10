class HireTiradorService
  def initialize(tirador_id, service_title, hired_by_id)
    @tirador_id = tirador_id
    @service_title = service_title
    @hired_by_id = hired_by_id

    @hirer = User.find(hired_by_id).profile
    @title = "New Hiring Request: #{service_title}"
    @client_full_name = "#{@hirer.first_name} #{@hirer.last_name}"
  end

  def call
    hiring = Hiring.create(
      tirador_id: @tirador_id,
      service_title: @service_title,
      hired_by_id: @hired_by_id
    )

    if hiring.persisted?
      NotificationJob.perform_async(
        @tirador_id, 
        @title, 
        @service_title, 
        @client_full_name, 
        @hirer.user.mobile_number
      )
    end

    hiring
  end
end
