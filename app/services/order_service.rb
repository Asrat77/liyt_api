class OrderService
  def get_location(name)
    api_key = ENV["GEBETA_API_KEY"]
    result = HTTParty.get("https://mapapi.gebeta.app/api/v1/route/geocoding?name=#{name}&apiKey=#{api_key}")
  end

  def calculate_price(origin, destination)
    distance_meters, time_taken_seconds = get_distance_and_time(origin, destination)
    directions = get_directions(origin, destination)
    distance_km = distance_meters / 1000.0
    rate_per_km = 5.0
    time_rate = 0.05
    total_price = (distance_km * rate_per_km) + (time_taken_seconds * time_rate)
    {"total_price" => total_price, "directions" => directions}
  end

  def get_distance_and_time(origin, destination)
    # Extract latitude and longitude from the origin and destination
    origin_lat, origin_lon = parse_location(origin)
    destination_lat, destination_lon = parse_location(destination)

    # Call the new API to get distance and time
    api_key = ENV["GEBETA_API_KEY"]
    response = HTTParty.get("https://mapapi.gebeta.app/api/v1/route/driving/direction/?la1=#{origin_lat}&lo1=#{origin_lon}&la2=#{destination_lat}&lo2=#{destination_lon}&apiKey=#{api_key}")

    # Parse the response
    total_distance = response.parsed_response["totalDistance"]
    time_taken = response.parsed_response["timetaken"]
    [total_distance, time_taken]
  end

  def get_directions(origin, destination)
    # Extract latitude and longitude from the origin and destination
    origin_lat, origin_lon = parse_location(origin)
    destination_lat, destination_lon = parse_location(destination)

    # Call the new API to get distance and time
    api_key = ENV["GEBETA_API_KEY"]
    response = HTTParty.get("https://mapapi.gebeta.app/api/v1/route/driving/direction/?la1=#{origin_lat}&lo1=#{origin_lon}&la2=#{destination_lat}&lo2=#{destination_lon}&apiKey=#{api_key}")

    directions = response.parsed_response["direction"]
    directions
  end

  def accept(order_id, driver_id)
    order = Order.find(order_id)
    raise(StandardError, "Order has already been accepted.") unless order.status == "pending"
    driver = User.find(driver_id)
    raise(StandardError, "Driver not found.") unless driver
    order.status = "in_progress"
    # order.update!(driver: driver)
    # order.driver_id = driver.id
    order.save
    {message: "Your Order with id #{order.id} has been accepted by our driver #{driver.first_name}"}
  end

  def complete(order_id, driver_id)
    order = Order.find(order_id)
    raise(StandardError, "Order has already been completed.") unless order.status == "in_progress"
    driver = User.find(driver_id)
    raise(StandardError, "Driver not found.") unless driver
    order.status = "delivered"
    order.driver_id = driver.id
    order.save
    {message: "Order has been completed by #{driver.first_name}"}
  end

  # def cancel(order_id)
  #   order = Order.find(order_id)
  #   raise(StandardError, "Order has already been cancelled.") unless order.status == "in_progress"
  #   order.status = "cancelled"
  #   order.save
  # end

  def get_orders_by_driver(driver_id)
    driver = User.find(driver_id)
    raise(StandardError, "Driver not found.") unless driver
    orders = Order.where(driver_id: driver.id)
    orders
  end

  def get_orders_by_user(user_id)
    user = User.find(user_id)
    raise(StandardError, "User not found.") unless user
    orders = Order.where(user_id: user.id)
    orders
  end



  private

  def parse_location(location)
    # Assuming location is a string in the format "latitude,longitude"
    lat, lon = location.split(',').map(&:strip)
    [lat, lon]
  end
end
