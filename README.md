Instagram Basic Display API Gem
===============================
A Ruby wrapper for the Instagram Basic Display API

Installation
------------
`gem install instagram_basic_display_api`

Instagram Basic Display API
---------------------------
Read the [documentation](https://developers.facebook.com/docs/instagram-basic-display-api).

Sample Application
------------------

```ruby
# Initialize the client with your access token
client = InstagramBasicDisplayAPI.client(access_token)

# Fetch the user account
user = client.user
puts "#{user.username}"

# Get your recent media items
for media_item in client.user_recent_media
  puts "#{media_item.thumbnail_url}"
end

# Find extended information about a specific media item
media_item = client.media_item(media_id)
puts "#{media_item.media_url}"

# Fetch the children of a carousel media item
for media_item in client.media_children(media_id)
  puts "#{media_item.media_type}"
end
```
