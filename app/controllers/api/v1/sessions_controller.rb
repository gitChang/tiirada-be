class Api::V1::SessionsController < ApplicationController
  # The `destroy` action will require an authenticated user.
  # We use `only` so the `create` (login) action remains public.
  before_action :require_user_to_be_signed_in, only: [:destroy, :update_fcm_token]

  
  def update_fcm_token
    if current_user.update(fcm_token: params[:token])
      render json: { message: 'FCM token updated successfully.' }, status: :ok
    else
      render json: { error: 'Failed to update FCM token.' }, status: :unprocessable_entity
    end
  end

  def create
    # The client will send a generic `login` parameter.
    identity_param = params[:identity]&.strip

    # Guard against a missing parameter to prevent errors.
    if identity_param.blank?
      render json: { error: 'email, username, or mobile number cannot be blank' }, status: :unprocessable_entity
      return
    end

    # Safely downcase the parameter.
    identity_param.strip.downcase!

    # Use `where` to build a query with OR conditions.
    # This is the safest way to prevent SQL injection.
    user = User.where('lower(email_address) = :identity OR lower(username) = :identity OR mobile_number = :identity',
                      { identity: identity_param }).first  

    if user&.authenticate(params[:password])

      user.update!(
        api_token_expires_at: 24.hours.from_now
      )

      # Successful authentication
      render json: {
        message: 'Login successful!',
        token: user.api_token,
        user_id: user.id.to_s,
      }, status: :created # 201
    else
      # Failed authentication
      render json: { error: 'Invalid credentials' }, status: :unauthorized # 401
    end    
  end

  def destroy
    sleep 2
    # To "log out" a user in a token-based system, we change their token.
    # This invalidates the token the client was using.
    current_user.regenerate_api_token

    # Respond with a success message and a 204 No Content status.
    render json: { message: 'Logged out successfully.' }, status: :no_content
  end
end
