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

client = InstagramBasicDisplayAPI.client(access_token)
user = client.user
puts "#{user.username}"

for media_item in client.user_recent_media
  puts "#{media_item.thumbnail_url}"
end
```
