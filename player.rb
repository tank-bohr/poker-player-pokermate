class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    game_state['current_buy_in'].to_i.nonzero? || game_state['minimum_raise']
  end

  def showdown(game_state)

  end

  def team(game_state)
    'pokermate' == game_state['players'].select { |player| player['name'].downcase }
  end
end
