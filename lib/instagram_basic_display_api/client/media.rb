module InstagramBasicDisplayAPI
  class Client
    module Media
      def media_item(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        id = args.first
        fields = options[:fields] || 'id,caption,media_type,media_url,permalink,thumbnail_url,timestamp,username'
        response = connection.get("#{id}?fields=#{fields}&access_token=#{access_token}")
        response.body
      end

      def media_children(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        id = args.first
        fields = options[:fields] || 'id,media_type,media_url,permalink,thumbnail_url,timestamp,username'
        limit = options[:limit] || ''
        after = options[:after] || ''
        response = connection.get("#{id}/children?fields=#{fields}&access_token=#{access_token}&limit=#{limit}&after=#{after}")
        response.body
      end
    end
  end
end