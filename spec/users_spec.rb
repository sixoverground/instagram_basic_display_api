require 'dotenv/load'
require File.expand_path('../../lib/instagram_basic_display_api', __FILE__)

describe InstagramBasicDisplayAPI::Client do
  context '.new' do
    before do
      @client = InstagramBasicDisplayAPI.client(access_token: ENV['ACCESS_TOKEN'])
    end

    describe '.user' do
      context 'with user ID passed' do
        it 'should return extended information of a given user' do
          user = @client.user('me')
          expect(user.username).to eq(ENV['USERNAME'])
        end
      end

      context 'without user ID passed' do
        it 'should return extended information of a given user' do
          user = @client.user
          expect(user.username).to eq(ENV['USERNAME'])
        end
      end
    end

    describe '.user_recent_media' do
      context 'with user ID passed' do
        it 'should return a list of recent media items for the given user' do
          recent_media = @client.user_recent_media('me')
          expect(recent_media).to be_a Array
          expect(recent_media.first.username).to eq(ENV['USERNAME'])
        end
      end

      context 'without user ID passed' do
        it 'should return a list of recent media items for the given user' do
          recent_media = @client.user_recent_media
          expect(recent_media).to be_a Array
          expect(recent_media.first.username).to eq(ENV['USERNAME'])
        end
      end
    end
  end
end