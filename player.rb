class Player

  VERSION = "Version 19"

  def bet_request(game_state)
    current_buy_in = game_state['current_buy_in'].to_i
    bet = game_state['bet'].to_i
    player = find_player(game_state)
    cards = find_cards(player)

    return game_state['minimum_raise'] if combination?(cards)
    return current_buy_in if high_card?(cards) && (bet - current_buy_in) < 100

    0
  end

  def showdown(game_state)

  end

  def find_player(game_state)
    game_state['players'][game_state['in_action']]
  end

  def find_cards(player)
    player['hole_cards']
  end

  def combination?(cards)
    (cards[0]['rank'] == cards[1]['rank']) || (cards[0]['suit'] == cards[1]['suit'])
  end

  def high_card?(cards)
    cards.any? { |c| Integer(c['rank']) rescue true }
  end
end
