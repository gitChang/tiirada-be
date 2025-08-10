class Api::V1::HiringsController < ApplicationController
  def create
    hp = hiring_params
    
    hiring = HireTiradorService.new(
      hp[:tirador_id],
      hp[:service_title],
      hp[:hired_by_id]
    ).call

    if hiring.persisted?
      render json: { message: "Tirador hired and notified." }, status: :created
    else
      render json: { errors: hiring.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def hiring_params
    params.require(:hiring).permit(:tirador_id, :service_title, :hired_by_id)
  end  
end
