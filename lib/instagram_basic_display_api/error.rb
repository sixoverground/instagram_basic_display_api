module InstagramBasicDisplayAPI
  # Custom error class for rescuing from all Instagram errors
  class Error < StandardError
    attr_reader :http_status, :payload

    def initialize(message = nil, http_status: nil, payload: nil)
      super(message)
      @http_status = http_status
      @payload     = payload
    end

    # Meta error code (e.g. 190 = token expired/invalid, 100 = object missing).
    # nil when the response carried no structured error body.
    def code
      hash = error_hash
      return hash['code'] if hash.key?('code')

      payload.is_a?(Hash) ? payload['code'] : nil
    end

    def error_subcode
      error_hash['error_subcode']
    end

    private

    def error_hash
      payload.is_a?(Hash) && payload['error'].is_a?(Hash) ? payload['error'] : {}
    end
  end

  # Raised when Instagram returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Instagram returns an expired/invalid access token (OAuthException
  # code 190), which Meta often delivers over HTTP 400, or over HTTP 401.
  class Unauthorized < Error; end

  # Raised when Instagram returns the HTTP status code 403
  class Forbidden < Error; end

  # Raised when Instagram returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Instagram returns the HTTP status code 429
  class TooManyRequests < Error; end

  # Raised when Instagram returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Instagram returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when Instagram returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when Instagram returns the HTTP status code 504
  class GatewayTimeout < Error; end

  # Raised when a subscription payload hash is invalid
  class InvalidSignature < Error; end

  # Raised when Instagram returns the HTTP status code 429
  class RateLimitExceeded < Error; end
end