class RaiseWeight < WeightCalc
  PAIR_WEIGHT = 100
  SUIT_WEIGHT = 50
  CARD_WEIGHTS = {
    '2' => 5,
    '3' => 10,
    '4' => 15,
    '5' => 20,
    '6' => 25,
    '7' => 30,
    '8' => 35,
    '9' => 40,
    '10' => 45,
    'J' => 50,
    'Q' => 110,
    'K' => 120,
    'A' => 130
  }

  def cards_weight(cards)
    weight = cards.map { |card| CARD_WEIGHTS[card['rank']] }.inject(:+)
    weight += PAIR_WEIGHT if pair?(cards)
    weight += SUIT_WEIGHT if suited?(cards)
    weight
  end

  def previous_action_weight
    0
  end

  private

  def pair?(cards)
    card_ranks(cards).uniq.length == 1
  end

  def suited?(cards)
    card_suits(cards).uniq.length == 1
  end
end
