require 'rspec'
require_relative '../player'

RSpec.describe Player do
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
      'current_buy_in' => 0,
      'pot' => 0
    }
  end

  let(:me) { game_state['players'][0] }

  describe '#bet_request' do
    context 'when bad cards' do
      before do
        me['hole_cards'] = [
          {
              "rank" => "6",
              "suit" => "hearts"
          },
          {
              "rank" => "2",
              "suit" => "spades"
          }
        ]
      end

      it 'folds' do
        bet = subject.bet_request(game_state)
        expect(bet).to eq(0)
      end
    end
  end

  describe 'cards_factor' do
    let(:game_state) do
      {
        'in_action' => 0,
        'players' => [
          'hole_cards' => cards
        ]
      }
    end

    subject { Player.new.decide(game_state) }

    context '2 and 5 off-suited' do
      let(:cards) { [{ 'rank' => '2', 'suit' => 'hearts' }, { 'rank' => '5', 'suit' => 'spades' }] }

      it 'fold wins' do
        expect(subject).to eq :fold
      end
    end

    context '8 and 9 suited' do
      let(:cards) { [{ 'rank' => '8', 'suit' => 'hearts' }, { 'rank' => '9', 'suit' => 'hearts' }] }

      it 'call wins' do
        expect(subject).to eq :call
      end
    end

    context 'Ace and King' do
      let(:cards) { [{ 'rank' => 'K', 'suit' => 'hearts' }, { 'rank' => 'A', 'suit' => 'spades' }] }

      it 'call wins' do
        expect(subject).to eq :call
      end
    end

    context 'pair' do
      let(:cards) { [{ 'rank' => '9', 'suite' => 'spades' }, { 'rank' => '9', 'suite' => 'hearts' }] }

      it 'raise wins' do
        expect(subject).to eq :raise
      end
    end
  end
end
