class Player

  VERSION = "Version 17"

  def bet_request(game_state)
    current_buy_in = game_state['current_buy_in'].to_i
    player = find_player(game_state)
    cards = find_cards(player)

    return game_state['minimum_raise'] if combination?(cards)

    0
  end

  def showdown(game_state)

  end

  def find_player(game_state)
    'pokermate' == game_state['players'].select { |player| player['name'].downcase }
  end

  def find_cards(player)
    player['hole_cards']
  end

  def combination?(cards)
    (cards[0]['rank'] == cards[1]['rank']) || (cards[0]['suit'] == cards[1]['suit'])
  end
end
