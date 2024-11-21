module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_api_key

      def index
        orders = Order.all
        render json: orders, status: :ok
      end

      def init
        primary_address = User.where(id: @user_id).pluck(:primary_address).first
        latitude, longitude = primary_address.values_at("latitude", "longitude")

        @order = Order.new(
          order_params.merge(
            user_id: @user_id,
            status: "scheduled",
            origin: "#{latitude}, #{longitude}",
            price: 0 # Set initial price
          )
        )

        if @order.save

          render json: {
            message: "Order has been successfully Initialized",
            order_id: @order.id,
            redirect_url: "https://litetest.vercel.app/Redirect/#{@order.id}"
          }
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def create
        @order = Order.find(params[:id]) # Find the initialized order
        update_params = order_complete_params.merge({
          status: "pending",
          price: params[:order][:price].to_f # Ensure the price is a float
        })

        if @order.update(update_params)
          render json: { message: "Order successfully created", order: @order }, status: :ok
        else
          render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def authenticate_api_key
        api_key = params[:api_key]
        @api_key = ApiKey.find_by(key: api_key)

        unless @api_key
          render json: { error: "Invalid or inactive API key" }, status: :unauthorized
        else
          @user_id = @api_key.user_id
        end
      end

      def order_params
        params.permit(:user_id)
      end

      def order_complete_params
        params.require(:order).permit(
          :destination,
          :destination_name,
          :customer_name,
          :customer_phone_number
        )
      end
    end
  end
end
