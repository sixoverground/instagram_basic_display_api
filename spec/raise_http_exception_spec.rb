require File.expand_path('../../lib/instagram_basic_display_api', __FILE__)
require 'faraday'
require 'json'

describe InstagramBasicDisplayAPI::RaiseHttpException do
  def get_with(status, body)
    conn = Faraday.new do |f|
      f.use InstagramBasicDisplayAPI::RaiseHttpException
      f.adapter :test do |stub|
        stub.get('/x') { [status, { 'Content-Type' => 'application/json' }, body] }
      end
    end
    conn.get('/x')
  end

  def oauth_190
    JSON.dump('error' => { 'message' => 'The access token is invalid', 'type' => 'OAuthException', 'code' => 190 })
  end

  def object_missing_100
    JSON.dump('error' => { 'message' => 'Object does not exist', 'type' => 'IGApiException', 'code' => 100 })
  end

  it 'raises Unauthorized for an OAuthException code 190 returned over HTTP 400' do
    expect { get_with(400, oauth_190) }.to raise_error(InstagramBasicDisplayAPI::Unauthorized) do |err|
      expect(err.http_status).to eq(400)
      expect(err.code).to eq(190)
    end
  end

  it 'raises Unauthorized for a plain HTTP 401' do
    expect { get_with(401, JSON.dump('error' => { 'message' => 'nope', 'code' => 1 })) }
      .to raise_error(InstagramBasicDisplayAPI::Unauthorized)
  end

  it 'raises BadRequest for a non-token HTTP 400 (code 100 object missing)' do
    expect { get_with(400, object_missing_100) }.to raise_error(InstagramBasicDisplayAPI::BadRequest) do |err|
      expect(err.code).to eq(100)
    end
  end

  it 'also detects a flat { "code": 190 } envelope' do
    expect { get_with(400, JSON.dump('code' => 190, 'error_message' => 'invalid token')) }
      .to raise_error(InstagramBasicDisplayAPI::Unauthorized)
  end

  it 'raises the status-mapped class for other errors' do
    expect { get_with(429, '{}') }.to raise_error(InstagramBasicDisplayAPI::TooManyRequests)
    expect { get_with(500, '{}') }.to raise_error(InstagramBasicDisplayAPI::InternalServerError)
  end

  it 'does not raise on a success' do
    expect { get_with(200, '{"data":[]}') }.not_to raise_error
  end
end
