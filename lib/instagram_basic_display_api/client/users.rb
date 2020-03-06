module InstagramBasicDisplayAPI
  class Client
    module Users
      def user(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        id = args.first || 'me'
        fields = options[:fields] || 'id,account_type,media_count,username'
        response = connection.get("#{id}?fields=#{fields}&access_token=#{access_token}")
        puts "user: #{response.body}"
        response.body
      end

      def user_recent_media(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        id = args.first || 'me'
        fields = options[:fields] || 'id,caption,media_type,media_url,permalink,thumbnail_url,timestamp,username'
        response = connection.get("#{id}/media?fields=#{fields}&access_token=#{access_token}")
        # puts "user recent media: #{response.body.data}"
        response.body.data
      end
    end
  end
end