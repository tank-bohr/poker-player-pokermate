class CallWeight < WeightCalc
  CARD_WEIGHTS = {
    '2' => 10,
    '3' => 20,
    '4' => 30,
    '5' => 40,
    '6' => 50,
    '7' => 60,
    '8' => 70,
    '9' => 80,
    '10' => 90,
    'J' => 100,
    'Q' => 110,
    'K' => 120,
    'A' => 130
  }

  def cards_weight(cards)
    cards.map { |card| CARD_WEIGHTS[card['rank']] }.inject(:+)
  end

  def previous_action_weight
    0
  end
end
