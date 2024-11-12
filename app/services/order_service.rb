class OrderService


  def get_location(name)
    api_key = ENV["GEBETA_API_KEY"]
    result = HTTParty.get("https://mapapi.gebeta.app/api/v1/route/geocoding?name=#{name}&apiKey=#{api_key}")
  end

end
