module InstagramBasicDisplayAPI
  class Client
    module Users
      def user(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        id = args.first || 'me'
        response = get("#{me}", options)
      end
    end
  end
end