class ApplicationController < ActionController::API
  # This line makes `authenticate_with_http_token` available to all controllers
  # that inherit from ApplicationController.
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # This line "includes" our custom Authentication module, making all its methods
  # available to this controller and any controller that inherits from it.
  include Authentication
end
