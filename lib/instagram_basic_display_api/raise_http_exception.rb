require 'faraday'
require 'json'

# @private
module InstagramBasicDisplayAPI
  # @private
  class RaiseHttpException < Faraday::Middleware
    # Meta returns expired / invalid / revoked access-token errors as an
    # OAuthException with code 190, frequently over HTTP 400 rather than 401.
    # We surface those as Unauthorized so callers can rescue the correct class
    # regardless of Meta's inconsistent status code.
    OAUTH_ACCESS_TOKEN_ERROR_CODE = 190

    def call(env)
      @app.call(env).on_complete do |response|
        status = response[:status].to_i
        next if status < 400

        payload = parse_payload(response[:body])
        klass   = exception_class(status, payload)
        next unless klass

        raise klass.new(error_message(response, status), http_status: status, payload: payload)
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def exception_class(status, payload)
      return InstagramBasicDisplayAPI::Unauthorized if access_token_error?(payload)

      case status
      when 400 then InstagramBasicDisplayAPI::BadRequest
      when 401 then InstagramBasicDisplayAPI::Unauthorized
      when 403 then InstagramBasicDisplayAPI::Forbidden
      when 404 then InstagramBasicDisplayAPI::NotFound
      when 429 then InstagramBasicDisplayAPI::TooManyRequests
      when 500 then InstagramBasicDisplayAPI::InternalServerError
      when 502 then InstagramBasicDisplayAPI::BadGateway
      when 503 then InstagramBasicDisplayAPI::ServiceUnavailable
      when 504 then InstagramBasicDisplayAPI::GatewayTimeout
      end
    end

    # True when the response carries an OAuthException access-token error
    # (code 190), whatever the HTTP status. Supports both the nested
    # `{ "error": { "code": 190 } }` envelope and a flat `{ "code": 190 }`.
    def access_token_error?(payload)
      extract_code(payload) == OAUTH_ACCESS_TOKEN_ERROR_CODE
    end

    def extract_code(payload)
      return nil unless payload.is_a?(Hash)

      err = payload['error']
      (err.is_a?(Hash) && err['code']) || payload['code']
    end

    def parse_payload(body)
      return body if body.is_a?(Hash)
      return {} unless body.is_a?(String) && !body.empty?

      JSON.parse(body)
    rescue JSON::ParserError
      {}
    end

    def error_message(response, status)
      case status
      when 500 then error_message_500(response, 'Something is technically wrong.')
      when 502 then error_message_500(response, 'The server returned an invalid or incomplete response.')
      when 503 then error_message_500(response, 'Instagram is rate limiting your requests.')
      when 504 then error_message_500(response, '504 Gateway Time-out')
      else error_message_400(response)
      end
    end

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{response[:status]}#{error_body(response[:body])}"
    end

    def error_body(body)
      # body gets passed as a string, not sure if it is passed as something else from other spots?
      if not body.nil? and not body.empty? and body.kind_of?(String)
        # removed multi_json thanks to wesnolte's commit
        if body == "Sorry, this content isn't available right now"
          body
        else
          body = ::JSON.parse(body)
        end
      end

      if body.nil?
        nil
      elsif body['error'] and body['error']['message'] and not body['error']['message'].empty?
        ": #{body['error']['message']}"
      end
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end
