require 'faraday_middleware'
require 'ostruct'
require 'faraday_middleware/raise_http_exception'

module InstagramBasicDisplayAPI
  module Connection
    def connection
      Faraday.new endpoint do |conn|
        # conn.response :json, content_type: /\bjson$/
        conn.response :json, content_type: /\bjson$/, parser_options: { object_class: OpenStruct }
        conn.use FaradayMiddleware::RaiseHttpException
        conn.adapter Faraday.default_adapter
      end
    end
  end
end