ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'json'
require_relative '../player_service'

describe 'The PlayerService App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "says version" do
    post '/', action: :version
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Version 17')
  end

  describe 'bet request' do
    let(:game_state) do
        {
          players: [
          {
            name: "Pokermate",
            stack: 1000,
            status: "active",
            bet: 0,
            hole_cards: [],
            version: "Version name 1",
            id: 0
          },
          {
            name: "Player 2",
            stack: 1000,
            status: "active",
            bet: 0,
            hole_cards: [],
            version: "Version name 2",
            id: 1
          }
        ],
        tournament_id: "550d1d68cd7bd10003000003",
        game_id: "550da1cb2d909006e90004b1",
        round: 0,
        bet_index: 0,
        small_blind: 10,
        orbits: 0,
        dealer: 0,
        community_cards: [],
        current_buy_in: 0,
        pot: 0
      }
    end

    let(:json) { JSON.dump(action: :bet_request, game_state: game_state) }
    let(:headers) { { "CONTENT_TYPE" => 'application/json' } }

    before { post '/', json, headers }

    it { expect(last_response).to be_ok }
  end
end
