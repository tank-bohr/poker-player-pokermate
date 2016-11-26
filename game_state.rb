require "poker_ranking"

class GameState
  attr_reader :attrs, :current_buy_in, :bet

  def initialize(attrs)
    @attrs = attrs
    @current_buy_in = attrs['current_buy_in'].to_i
    @bet = player['bet'].to_i
  end

  def player
    @player ||= attrs['players'][attrs['in_action']]
  end

  def preflop?
    community_cards.empty?
  end

  def hand
    @hand ||= player['hole_cards']
  end

  def community_cards
    @community_cards ||= attrs['community_cards']
  end

  def pair?
    (hand[0]['rank'] == hand[1]['rank'])
  end

  def potential_flush?
    hand[0]['suit'] == hand[1]['suit']
  end

  def high_card?
   hand.any? { |card| card['rank'].to_i.zero? } # 'A'.to_i == 0
  end

  def rank
    ranking_data = PokerRanking::Hand.new(community_cards + hand).data
    ranking_data[:rank]
  end

  def check_fold
    0
  end

  def safe_call
    small_bet? ? current_buy_in : check_fold
  end

  def raise
    minimum_raise = attrs['minimum_raise'].to_i
    current_buy_in - bet + minimum_raise
  end

  def all_in
    player['stack']
  end

  def small_bet?
    bet - current_buy_in < 200
  end
end
