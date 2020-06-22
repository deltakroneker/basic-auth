class JsonWebToken
  ALGORITHM = "HS256"
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base, ALGORITHM)
    end

    def decode(token)
      body = JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM })[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end
