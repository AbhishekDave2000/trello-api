class JsonWebToken
  SECRET_KEY = Rails.application.secret_key_base
  EXPIRY     = 24.hours.from_now

  def self.encode(payload, exp = EXPIRY)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end
end
