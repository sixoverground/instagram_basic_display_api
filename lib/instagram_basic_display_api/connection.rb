require 'faraday_middleware'
require 'ostruct'

module InstagramBasicDisplayAPI
  module Connection
    def connection
      Faraday.new endpoint do |conn|
        # conn.response :json, content_type: /\bjson$/
        conn.response :json, content_type: /\bjson$/, parser_options: { object_class: OpenStruct }
        conn.adapter Faraday.default_adapter
      end
    end
  end
end