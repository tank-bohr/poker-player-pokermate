require_relative 'ranking_client'

class Player

  VERSION = "Version 24"

  def bet_request(game_state)
    if game_state['community_cards'].empty?
      preflop(game_state)
    else
      flop(game_state)
    end
  end

  def preflop(game_state)
    current_buy_in = game_state['current_buy_in'].to_i
    player = find_player(game_state)
    bet = player['bet'].to_i
    cards = find_cards(player)


    return (current_buy_in - bet + game_state['minimum_raise']) if pair?(cards)
    return current_buy_in if (high_card?(cards) || potential_suit?(cards)) && (bet - current_buy_in) < 250

    0
  end

  def flop(game_state)
    current_buy_in = game_state['current_buy_in'].to_i
    player = find_player(game_state)
    bet = player['bet'].to_i
    minimum_raise = game_state['minimum_raise']

    case rank(game_state)
    when 0 then 0
    when 1..2 then (bet - current_buy_in < 200 ? current_buy_in : 0)
    when 3..5 then current_buy_in - bet + minimum_raise
    when 5..8 then player['stack']
    end
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

  def rank(game_state)
    cards = game_state['community_cards'] +
            game_state['players'][game_state['in_action']]['hole_cards']

    client = RankingClient.new
    client.rank_raw(cards)['rank']
  rescue
    0
  end
end
