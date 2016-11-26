require_relative 'ranking_client'

class Player

  VERSION = "Version 22"

  def bet_request(game_state)
    _current_buy_in = game_state['current_buy_in'].to_i
    _bet = game_state['bet'].to_i
    player = find_player(game_state)
    bet = player['bet'].to_i
    cards = find_cards(player)


    return (current_buy_in - bet + game_state['minimum_raise']) if pair?(cards)
    return current_buy_in if (high_card?(cards) || potential_suit?(cards)) && (bet - current_buy_in) < 250

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

  def pair?(cards)
    (cards[0]['rank'] == cards[1]['rank'])
  end

  def potential_suit?(cards)
    cards[0]['suit'] == cards[1]['suit']
  end

  def high_card?(cards)
   cards.any? { |card| card['rank'].to_i.zero? } # 'A'.to_i == 0
  end

  def rank_raw(game_state)
    cards = game_state['community_cards'] +
            game_state['players'][game_state['in_action']]['hole_cards']

    client = RankingClient.new
    client.rank_raw(cards)
  end
end
