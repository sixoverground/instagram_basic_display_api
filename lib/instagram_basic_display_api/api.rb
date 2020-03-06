require 'instagram_basic_display_api/connection'

module InstagramBasicDisplayAPI
  class API
    attr_accessor :access_token
    attr_accessor :endpoint

    def initialize(options={})
      self.access_token = options[:access_token]
      self.endpoint = options[:endpoint]
    end

    include Connection
  end
end