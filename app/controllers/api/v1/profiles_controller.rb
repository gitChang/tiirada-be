class Api::V1::ProfilesController < ApplicationController
  # This before_action uses our Authentication concern to protect the endpoint
  before_action :require_user_to_be_signed_in

  def create
    if current_user.profile
      # Update existing profile
      if current_user.profile.update(profile_params)
        # Use the build_more_info method to 
        # update an associated record
        primary_service = current_user.profile.primary_service # primary service offered
        current_user.profile.more_info.update(active_service: primary_service)


        render json: {
          message: 'Profile updated successfully',
        }, status: :created
      else
        render json: { errors: current_user.profile.errors.full_messages }, status: :unprocessable_entity
      end
    else
      # Create new profile
      @new_profile = current_user.build_profile(profile_params)

      if @new_profile.save
        # Use the build_more_info method
        primary_service = @new_profile.primary_service # primary service offered
        more_info = @new_profile.build_more_info(active_service: primary_service)

        more_info.save

        render json: {
          message: 'Profile created successfully',
        }, status: :created
      else
        render json: { errors: @new_profile.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end


  def show
    if current_user.profile.present?
      # Safely check if a photo is attached before calling url_for
      photo_url = if current_user.profile.photo.attached?
                    url_for(current_user.profile.photo)
                  else
                    nil
                  end

      render json: current_user.profile.as_json.merge(
        photo_url: photo_url
      ), status: :ok
    else
      render json: { error: "No profile found" }, status: :not_found
    end
  end

  
  private

  def profile_params
    params.require(:profile).permit(
      :last_name, :first_name, :middle_name, :birth_date, 
      :sex, :province, :town, :barangay, :street,  
      :primary_service, :secondary_service, :tertiary_service, 
      :photo
    )
  end
  
end
