class Api::V1::SignupController < ApplicationController
  def create
    @user = User.new(signup_params)

    if @user.save
      render json: { 
        message: 'User created successfully', 
        token: @user.api_token 
      }, status: :created # Respond with a 201 status code
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    params.require(:user).permit(:mobile_number, :email_address, :username, :password, :password_confirmation)
  end
end
