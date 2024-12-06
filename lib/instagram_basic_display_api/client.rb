module InstagramBasicDisplayAPI
  class Client < API
    require 'instagram_basic_display_api/client/users'
    require 'instagram_basic_display_api/client/media'
    require 'instagram_basic_display_api/client/access_token'

    include InstagramBasicDisplayAPI::Client::Users
    include InstagramBasicDisplayAPI::Client::Media
    include InstagramBasicDisplayAPI::Client::AccessToken
  end
end
