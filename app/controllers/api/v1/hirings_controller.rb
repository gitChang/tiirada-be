class Api::V1::HiringsController < ApplicationController
  # This before_action uses our Authentication concern to protect the endpoint
  before_action :require_user_to_be_signed_in

  def create
    hp = hiring_params

    hiring = HireTiradorService.new(
      current_user,
      hp[:service_request],
      hp[:tirador_id],
    ).call

    if hiring.persisted?
      # Update "hired" status
      hiring.tirador.profile.more_info.update(is_hired: true)

      render json: { message: "Tirador request service sent and notified." }, status: :created
    else
      render json: { errors: hiring.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def hiring_params
    params.require(:hiring).permit(:service_request, :tirador_id)
  end  
end
