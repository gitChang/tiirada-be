class Api::V1::ClientsController < ApplicationController
  # This before_action uses our Authentication concern to protect the endpoint
  before_action :require_user_to_be_signed_in

  def show
    client = Profile.includes(:more_info, :reviews)
                    .find_by(id: params[:client_id])

    if client      
      client_json = client.as_json.merge(
        photo_url: client.photo.attached? ? url_for(client.photo) : nil
      )

      if client.more_info.present?
        client_json.merge!(
          mobile_number: client.user.mobile_number,
          is_verified: client.more_info.is_verified,
          average_rating: client.more_info.average_rating
        )
      end

      render json: {
        client: client_json,
        reviews: client.user.reviews_as_client.as_json(only: [:id, :rating, :comment, :created_at])
      }, status: :ok
    else      
      render json: { error: 'Client not found' }, status: :not_found
    end
  end
end