class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy ]

  def location
    service = OrderService.new
    result = service.get_location(params[:name])
    render json: { payload: result }
  end

  def get_price
    service = OrderService.new
    origin = params[:origin]
    destination = params[:destination]

    if origin.present? && destination.present?
      result = service.calculate_price(origin, destination)
      render json: { payload: result }
    else
      render json: { error: "Origin and destination must be provided." }, status: :unprocessable_entity
    end
  end
  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :driver_id, :status, :origin, :destination, :price, :customer_name, :customer_phone_number)
    end
end
