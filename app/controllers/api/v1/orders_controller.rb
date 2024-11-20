module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_api_key

      def index
          orders = Order.all
          render json: orders, status: :ok
      end

      def init
        @order = Order.new(order_params)
        @order.user_id = @user_id
        @order.status = "pending"
        @order.origin = User.find(@user_id).primary_address
        @order.price = 0 # set initial price
        if @order.save
          render json: "https://litetest.vercel.app/Redirect/#{@user_id}"
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      private
      def authenticate_api_key
        api_key = params[:api_key]
        @api_key = ApiKey.find_by(key: api_key)
        @user_id = @api_key.user_id
        # debugger

        unless @api_key
          render json: { error: "Invalid or inactive API key" }, status: :unauthorized
        end
      end

      def order_params
         params.require(:order).permit(user_id: @user_id)
       end

    end
  end
end
