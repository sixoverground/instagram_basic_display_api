module InstagramBasicDisplayAPI
  class Client
    require 'users'

    include InstagramBasicDisplayAPI::Client::Users

    def initialize(options={})

    end
  end
end