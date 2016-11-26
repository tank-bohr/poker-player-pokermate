require_relative './game_state'
require_relative 'strategy'
require_relative 'weight_calc'
require_relative 'fold_weight'
require_relative 'call_weight'
require_relative 'raise_weight'

class BetRequest
  include Strategy

  ACTIONS_WEIGHTS = {
    fold: FoldWeight,
    call: CallWeight,
    raise: RaiseWeight
  }

  attr_reader :game_state, :player, :bet

  def self.call(game_state_hash)
    new(game_state_hash).call
  end

  def initialize(game_state_hash)
    @game_state = GameState.new(game_state_hash)
    @player = game_state.player
    @bet = player['bet'].to_i
  end

  def call
    if game_state.preflop?
      preflop
    else
      flop
    end
  end

  def preflop
    if game_state.pair?
      game_state.raise
    elsif game_state.high_card? || game_state.potential_flush?
      game_state.safe_call
    else
      game_state.check_fold
    end
  end

  def flop
    case game_state.rank
    when 0 then game_state.check_fold
    when 1 then game_state.safe_call
    when 2..3 then game_state.raise
    when 4..5 then game_state.all_in / 2
    when 6..8 then game_state.all_in
    end
  end

  def super_duper_new_strategy
    action_weights = ACTIONS_WEIGHTS.each_with_object({}) do |(_, weight_calc), memo|
      memo[weight_calc.name] = weight_calc.call(game_state)
    end

    action, weight = weights.max_by { |_, v| v }
    case action
    when :fold
    when :call
    when :raise
    else
    end
  end
end
