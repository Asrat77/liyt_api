class TokenService
  def self.issue(payload)
    JWT.encode(payload, key, "HS256")
  end

  def self.decode(token)
    JWT.decode(token, key, true, algorithm: "HS256").first
  end

  def self.key
    ENV["SECRET_KEY"] || Rails.application.credentials.secret_key_base
  end
end
