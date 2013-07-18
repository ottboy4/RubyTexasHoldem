require_relative 'card.rb'

class Deck
  def initialize
    fill_deck
  end

  def fill_deck
    @cards = Array.new
    fill_cards(Suit::DIAMOND)
    fill_cards(Suit::HEART)
    fill_cards(Suit::CLUB)
    fill_cards(Suit::SPADE)
  end

  def fill_cards(suit)
    for i = 1 in i <= 13 do
      @cards.push(Card.new(i, suit))
    end
  end

  def score_cards(cards)

  end

  def is_straight?(cards)
    new_cards = cards.sort { |x,y| x.number < y.number}

  end

  def is_flush?(cards)

  end

end

module Values
  STRAIGHT_FLUSH = 1000
  FOUR_OF_A_KIND = 900
  FULL_HOUSE = 800
  FLUSH = 700
  STRAIGHT = 600
  THREE_OF_A_KIND = 500
  TWO_PAIR = 400
  ONE_PAIR = 300
end