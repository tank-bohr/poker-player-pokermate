require_relative 'weight_calc'
require_relative 'fold_weight'
require_relative 'call_weight'
require_relative 'raise_weight'

module Strategy
  ACTIONS_WEIGHTS = {
    fold: FoldWeight,
    call: CallWeight,
    raise: RaiseWeight
  }

  def decide(game_state)
    action_weights = ACTIONS_WEIGHTS.each_with_object({}) do |(action, weight_calc), memo|
      memo[action] = weight_calc.new(game_state).call
    end

    puts action_weights

    if action_weights[:call] == action_weights[:raise] && action_weights[:call] > action_weights[:fold]
      :call
    else
      action_weights.max_by { |(_, v)| v }.first
    end
  end
end
