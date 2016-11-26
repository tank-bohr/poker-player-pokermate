ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require_relative '../player_service'

describe 'The PlayerService App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says hello" do
    post '/', action: :version
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Version 17')
  end
end
