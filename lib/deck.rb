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

end
