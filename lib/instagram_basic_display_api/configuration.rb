module InstagramBasicDisplayAPI
  module Configuration
    attr_accessor :access_token
    attr_accessor :endpoint

    DEFAULT_ENDPOINT = 'https://graph.instagram.com/'.freeze

    def self.extended(base)
      base.reset
    end

    def options
      { access_token: access_token, endpoint: endpoint }
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
    end
  end
end