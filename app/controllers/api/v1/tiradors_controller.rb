class Api::V1::TiradorsController < ApplicationController
  # This before_action uses our Authentication concern to protect the endpoint
  before_action :require_user_to_be_signed_in

  def index
    service_title = params[:service_title]

    # Eager-load the 'more_info' association and filter by its 'active_service' column
    tiradors = Profile.includes(:more_info).where(more_infos: { active_service: service_title })

    render json: {
      tiradors: tiradors.map do |profile|
        # Start with the profile's default JSON representation
        json = profile.as_json

        # Manually merge attributes from the 'more_info' association at the top level
        if profile.more_info.present?
          json.merge!(
            is_verified: profile.more_info.is_verified,
            average_rating: profile.more_info.average_rating
          )
        end

        # Merge the photo URL
        json.merge!(
          photo_url: profile.photo.attached? ? url_for(profile.photo) : nil
        )
        
        json
      end
    }, status: :ok
  end

  def show
    tirador = Profile.includes(:more_info, :reviews)
                     .find_by(id: params[:tirador_id])

    if tirador      
      tirador_json = tirador.as_json.merge(
        photo_url: tirador.photo.attached? ? url_for(tirador.photo) : nil
      )

      if tirador.more_info.present?
        tirador_json.merge!(
          mobile_number: tirador.user.mobile_number,
          active_service: tirador.more_info.active_service,
          is_verified: tirador.more_info.is_verified,
          average_rating: tirador.more_info.average_rating
        )
      end

      render json: {
        tirador: tirador_json,
        reviews: tirador.reviews.as_json(only: [:id, :rating, :comment, :reviewer_name, :created_at])
      }, status: :ok
    else      
      render json: { error: 'Tirador not found' }, status: :not_found
    end
  end
end