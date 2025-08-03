class Api::V1::SearchServiceController < ApplicationController
  # This before_action uses our Authentication concern to protect the endpoint
  before_action :require_user_to_be_signed_in

  def index
    render json: { message: 'Welcome to the Services API!' }, status: :ok
  end

  def result
    serviceTitle = params[:service_title]

    tiradors = Profile.where("? IN (service_1, service_2, service_3)", serviceTitle)

    render json: {
      tiradors: tiradors.map do |profile|
        profile.as_json.merge(
          photo_url: profile.photo.attached? ? url_for(profile.photo) : nil
        )
      end
    }, status: :ok
  end

end
