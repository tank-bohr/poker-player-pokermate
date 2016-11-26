class WeightCalc
  attr_reader :game_state

  def initialize(game_state)
    @game_state = game_state
  end

  def cards
    player['hole_cards']
  end

  def player
    game_state['players'][game_state['in_action']]
  end
end
