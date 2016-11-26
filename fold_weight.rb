class FoldWeight < WeightCalc
  CARD_WEIGHTS = {
    '2' => 130,
    '3' => 120,
    '4' => 110,
    '5' => 100,
    '6' => 90,
    '7' => 80,
    '8' => 70,
    '9' => 60,
    '10' => 50,
    'J' => 40,
    'Q' => 30,
    'K' => 20,
    'A' => 10
  }

  def cards_weight(cards)
    cards.map { |card| CARD_WEIGHTS[card['rank']] }.inject(:+)
  end

  def previous_action_weight
    0
    # if small_blind?

    # end
  end
end
