require 'dotenv/load'
require File.expand_path('../../lib/instagram_basic_display_api', __FILE__)

describe InstagramBasicDisplayAPI::Client do
  context '.new' do
    before do
      @client = InstagramBasicDisplayAPI.client(access_token: ENV['ACCESS_TOKEN'])
    end

    describe '.media_item' do
      it 'should return extended information of a given media item' do
        media = @client.media_item(ENV['MEDIA_ID'])
        expect(media.username).to eq(ENV['USERNAME'])
      end
    end

    describe '.media_children' do
      it 'should return list of children media for the given media item' do
        media = @client.media_children(ENV['MEDIA_ID'])
        expect(media.data.first.username).to eq(ENV['USERNAME'])
      end
    end
  end
end