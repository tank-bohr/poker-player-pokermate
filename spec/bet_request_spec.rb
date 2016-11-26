require 'rspec'
require_relative '../bet_request'

RSpec.describe BetRequest do
  let(:game_state) do
    {
      'players' => [
        {
          'name' => "Player 1",
          'stack' => 1000,
          'status' => "active",
          'bet' => 0,
          'hole_cards' => [],
          'version' => "Version name 1",
          'id' => 0
        },
        {
          'name' => "Player 2",
          'stack' => 1000,
          'status' => "active",
          'bet' => 0,
          'hole_cards' => [],
          'version' => "Version name 2",
          'id' => 1
        }
      ],
      'in_action' => 0,
      'tournament_id' => "550d1d68cd7bd10003000003",
      'game_id' => "550da1cb2d909006e90004b1",
      'round' => 0,
      'bet_index' => 0,
      'small_blind' => 10,
      'orbits' => 0,
      'dealer' => 0,
      'community_cards' => [],
      'current_buy_in' => 20,
      'minimum_raise' => 20,
      'pot' => 0
    }
  end

  describe '::call' do
    subject { described_class.call(game_state) }

    context 'when flop' do
      let(:player_cards) do
        [
          { 'rank' => '3', 'suit' => 'spades' },
          { 'rank' => '5', 'suit' => 'spades' }
        ]
      end

      let(:community_cards) do
        [
          { 'rank' => '6', 'suit' => 'spades' },
          { 'rank' => '9', 'suit' => 'spades' },
          { 'rank' => '4', 'suit' => 'spades' },
          { 'rank' => 'K', 'suit' => 'hearts' },
        ]
      end

      before do
        game_state['players'][0]['hole_cards'] = player_cards
        game_state['community_cards'] = community_cards
      end

      it 'raises big' do
        expect(subject).to eq(500)
      end
    end

    context 'when preflop' do
      before do
        game_state['players'][0]['hole_cards'] = cards
      end

      context 'when pair' do
        let(:cards) do
          [
            { 'rank' => 'A', 'suit' => 'hearts' },
            { 'rank' => 'A', 'suit' => 'spades' }
          ]
        end

        it 'raises' do
          expect(subject).to eq(40)
        end
      end

      context 'when potential flush' do
        let(:cards) do
          [
            { 'rank' => '3', 'suit' => 'spades' },
            { 'rank' => '5', 'suit' => 'spades' }
          ]
        end

        it 'calls' do
          expect(subject).to eq(20)
        end
      end

      context 'when bad hand' do
        let(:cards) do
          [
            { 'rank' => '2', 'suit' => 'hearts' },
            { 'rank' => '3', 'suit' => 'spades' }
          ]
        end

        it 'check folds' do
          expect(subject).to eq(0)
        end
      end
    end
  end
end
