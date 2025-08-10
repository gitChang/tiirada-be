class TiradorMailer < ApplicationMailer
  def new_hiring_request(tirador, client_name, client_mobile)
    @tirador = tirador
    @client_name = client_name
    @client_mobile = client_mobile
    
    mail(
      to: @tirador.email_address,
      subject: "You have a new hiring request!"
    )
  end  
end
