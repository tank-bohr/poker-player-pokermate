class WeightCalc
  attr_reader :game_state

  CARD_WEIGHTS = {
    '2' => 10,
    '3' => 20,
    '4' => 30,
    '5' => 40,
    '6' => 50,
    '7' => 60,
    '8' => 70,
    '9' => 80,
    '10' => 90,
    'J' => 100,
    'Q' => 110,
    'K' => 120,
    'A' => 130
  }

  def initialize(game_state)
    @game_state = game_state
  end

  def call
    cards_weight(cards) + previous_action_weight
  end

  def cards
    player['hole_cards']
  end

  def player
    game_state['players'][game_state['in_action']]
  end

  def preflop?
    game_state['community_cards'].blank?
  end

  def card_ranks(cards)
    cards.map { |card| card['rank'] }
  end

  def card_suits(cards)
    cards.map { |card| card['suit'] }
  end

  def dealer
    game_state['players'][game_state['dealer']]
  end

  def dealer?
    game_state['in_action'] == game_state['dealer']
  end

  def small_blind?
    game_state['in_action'] == game_state['dealer'] + 1
  end

  def big_blind?
    game_state['in_action'] == game_state['dealer'] + 2
  end
end
