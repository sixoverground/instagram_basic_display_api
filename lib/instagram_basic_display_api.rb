require 'instagram_basic_display_api/error'
require 'instagram_basic_display_api/configuration'
require 'instagram_basic_display_api/api'
require 'instagram_basic_display_api/client'

module InstagramBasicDisplayAPI
  extend Configuration
  
  def self.client(options={})
    options = InstagramBasicDisplayAPI.options.merge(options)
    InstagramBasicDisplayAPI::Client.new(options)
  end
end