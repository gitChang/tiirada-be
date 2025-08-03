class Api::V1::HomeController < ApplicationController
  # This before_action uses our Authentication concern to protect the endpoint
  before_action :require_user_to_be_signed_in

  def index
    render json: { message: 'Welcome to the API!' }, status: :ok
  end
end
