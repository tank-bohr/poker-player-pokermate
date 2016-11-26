
class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    team(game_state)['stack']
  end

  def showdown(game_state)

  end

  def team(game_state)
    game_state['players'].select { |player| player['name'].downcase = 'pokermate' }
  end
end
