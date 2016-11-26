require 'sinatra'
require 'json'
require 'logger'
require_relative 'player'

set :port, 8090
set :bind, '0.0.0.0'

logger = Logger.new(STDOUT).tap { |l| l.level = 0 }

post "/" do
  logger.debug { params }
  if params[:action] == 'bet_request'
    Player.new.bet_request(JSON.parse(params[:game_state])).to_s
  elsif params[:action] == 'showdown'
    Player.new.showdown(JSON.parse(params[:game_state]))
    'OK'
  elsif params[:action] == 'version'
    Player::VERSION
  else
    'OK'
  end
end
