require 'pp'
require_relative './bet_request'

class Player

  VERSION = 'Version 26'

  def bet_request(game_state)
    BetRequest.call(game_state)
  end


  def showdown(game_state)

  end
end
