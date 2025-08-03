module Authentication
  extend ActiveSupport::Concern

  private

  def current_user
    # THE FIX IS HERE: `self.` makes the method call explicit and resolves the scope issue.
    @current_user ||= authenticate_with_http_token do |token, options|
      user = User.find_by(api_token: token)
    
      # Token is valid only if it exists and hasn't expired
      if user && user.api_token_expires_at && user.api_token_expires_at.future?
        user
      else
        nil
      end
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def require_user_to_be_signed_in
    render json: { error: 'Unauthorized. A valid token must be provided.' }, status: :unauthorized unless user_signed_in?
  end
end