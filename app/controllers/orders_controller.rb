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

  # POST /orders/:order_id/accept/:driver_id
  def accept
    service = OrderService.new
    driver_id = params[:driver_id]
    order_id= params[:order_id]
    result = service.accept(order_id, driver_id)
    render json: result, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # POST /orders/:id/complete
  def complete
    service = OrderService.new
    driver_id = params[:driver_id]
    result = service.complete(@order.id, driver_id)
    render json: result, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # GET /drivers/:driver_id/orders
  def get_orders_by_driver
    service = OrderService.new
    driver_id = params[:driver_id]
    orders = service.get_orders_by_driver(driver_id)

    if orders.empty?
      render json: { message: "No orders found for you currently, try again later." }, status: :ok
    else
      render json: orders
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # GET /users/:user_id/orders
  def get_orders_by_user
    service = OrderService.new
    user_id = params[:user_id]
    orders = service.get_orders_by_user(user_id)

    if orders.empty?
      render json: { message: "Looks like you haven't placed any orders yet. Create your first order today!" }, status: :ok
    else
      render json: orders
    end
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private
  # Only allow a list of trusted parameters through.

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :driver_id, :status, :origin, :destination, :price, :customer_name, :customer_phone_number)
  end
end
