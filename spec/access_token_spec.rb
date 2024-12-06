require 'dotenv/load'
require File.expand_path('../lib/instagram_basic_display_api', __dir__)

describe InstagramBasicDisplayAPI::Client do
  context '.new' do
    before do
      @client = InstagramBasicDisplayAPI.client(access_token: ENV['ACCESS_TOKEN'])
    end

    describe '.refresh_access_token' do
      context 'with client secret included' do
        it 'should refresh the access token' do
          access_token = @client.refresh_access_token
          expect(access_token.token_type).to eq('bearer')
        end
      end
    end
  end
end
