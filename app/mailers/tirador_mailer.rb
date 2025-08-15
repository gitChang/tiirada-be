class TiradorMailer < ApplicationMailer
  def new_hiring_request(tirador, service_request, client_name, client_mobile)
    @tirador = tirador
    @service_request = service_request
    @client_name = client_name
    @client_mobile = client_mobile
    
    mail(
      to: @tirador.email_address,
      subject: "You have a new service request!"
    )
  end  
end
