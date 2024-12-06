module InstagramBasicDisplayAPI
  class Client
    module AccessToken
      def refresh_access_token
        response = connection.get("refresh_access_token?grant_type=ig_refresh_token&access_token=#{access_token}")
        response.body
      end
    end
  end
end
