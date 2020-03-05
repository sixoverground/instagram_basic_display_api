require 'client'

module InstagramBasicDisplayAPI
  
  def self.client(options={})
    Client.new(options)
  end
end