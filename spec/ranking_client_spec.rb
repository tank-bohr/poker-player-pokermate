require 'rspec'
require 'webmock/rspec'
require_relative '../ranking_client'

RSpec.describe RankingClient do
  describe 'rank_raw' do
    let(:cards) do
      [
        {"rank" => "5", "suit" => "diamonds"},
        {"rank" => "6", "suit" => "diamonds"},
        {"rank" => "7", "suit" => "diamonds"},
        {"rank" => "7", "suit" => "spades"},
        {"rank" => "8", "suit" => "diamonds"},
        {"rank" => "9", "suit" => "diamonds"}
      ]
    end

    let(:response_body) do
      %(
        {
            "rank": 8,
            "value": 9,
            "second_value": 9,
            "kickers": [9, 8, 6, 5],
            "cards_used": [
                {
                    "rank": "5",
                    "suit": "diamonds"
                },
                {
                    "rank": "6",
                    "suit": "diamonds"
                },
                {
                    "rank": "7",
                    "suit": "diamonds"
                },
                {
                    "rank": "8",
                    "suit": "diamonds"
                },
                {
                    "rank": "9",
                    "suit": "diamonds"
                }
            ],
            "cards": [
                {
                    "rank": "5",
                    "suit": "diamonds"
                },
                {
                    "rank": "6",
                    "suit": "diamonds"
                },
                {
                    "rank": "7",
                    "suit": "diamonds"
                },
                {
                    "rank": "7",
                    "suit": "spades"
                },
                {
                    "rank": "8",
                    "suit": "diamonds"
                },
                {
                    "rank": "9",
                    "suit": "diamonds"
                }
            ]
        }
      )
    end

    before do
      stub_request(:post, "http://rainman.leanpoker.org/rank").to_return(body: response_body)
    end

    it 'returns rank' do
      rank = subject.rank_raw(cards)
      expect(rank['rank']).to eq(8)
      expect(rank['value']).to eq(9)
      expect(rank['second_value']).to eq(9)
    end

  end
end
