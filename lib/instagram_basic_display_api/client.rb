module InstagramBasicDisplayAPI
  class Client < API
    require 'instagram_basic_display_api/client/users'
    require 'instagram_basic_display_api/client/media'

    include InstagramBasicDisplayAPI::Client::Users
    include InstagramBasicDisplayAPI::Client::Media
  end
end