class AccessController < ApplicationController
  # skip_before_action :authenticate, only: [:login, :signup]
  def login
    user = User.find_by(email: auth_params[:email])
    if user.authenticate(auth_params[:password])
      payload = {
        id: user.id,
        email: user.email,
      }
      jwt = TokenService.issue(payload)
        render json: {token: jwt, user: payload}
      else
        render json: {error: "Invalid password."}, status: 400
      end
  end

  def signup
    @user = User.new(signup_params)

    if @user.save
      payload = {
        id: @user.id,
        email: @user.email,
      }
      jwt = TokenService.issue(payload)
      render json: { token: jwt, user: payload }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end

  def signup_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number, :business_name, :business_email, :primary_address, :secondary_address)
  end
end
