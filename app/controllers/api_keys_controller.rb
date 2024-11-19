class ApiKeysController < ApplicationController

  # GET /api/v1/api_keys
  def index
    api_keys = current_user.api_keys
    render json: api_keys, status: :ok
  end

  # POST /api/v1/api_keys
  def create
    api_key = current_user.api_keys.new(api_key_params)

    if api_key.save
      render json: { message: "API key created successfully", api_key: api_key }, status: :created
    else
      render json: { errors: api_key.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/api_keys/:id
  def destroy
    api_key = current_user.api_keys.find(params[:id])
    api_key.destroy!
    render json: { message: "API key deleted successfully" }, status: :ok
  end

  private

  def api_key_params
    params.require(:api_key).permit(:name, :expires_at)
  end
end
