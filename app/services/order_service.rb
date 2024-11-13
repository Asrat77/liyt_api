class OrderService
  def get_location(name)
    api_key = ENV["GEBETA_API_KEY"]
    result = HTTParty.get("https://mapapi.gebeta.app/api/v1/route/geocoding?name=#{name}&apiKey=#{api_key}")
  end

  def calculate_price(origin, destination)
    distance_meters, time_taken_seconds = get_distance_and_time(origin, destination)
    distance_km = distance_meters / 1000.0
    rate_per_km = 5.0
    time_rate = 0.05
    total_price = (distance_km * rate_per_km) + (time_taken_seconds * time_rate)
    total_price
  end

  def get_distance_and_time(origin, destination)
    # Extract latitude and longitude from the origin and destination
    origin_lat, origin_lon = parse_location(origin)
    destination_lat, destination_lon = parse_location(destination)

    # Call the new API to get distance and time
    api_key = ENV["GEBETA_API_KEY"]
    response = HTTParty.get("https://mapapi.gebeta.app/api/v1/route/driving/direction/?la1=#{origin_lat}&lo1=#{origin_lon}&la2=#{destination_lat}&lo2=#{destination_lon}&apiKey=#{api_key}")

    # Parse the response
    total_distance = response.parsed_response["totalDistance"] # Adjust based on actual response structure
    time_taken = response.parsed_response["timetaken"] # Adjust based on actual response structure
    [total_distance, time_taken] # Return both values
  end

  private

  def parse_location(location)
    # Assuming location is a string in the format "latitude,longitude"
    lat, lon = location.split(',').map(&:strip)
    [lat, lon]
  end
end
