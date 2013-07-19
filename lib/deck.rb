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
    for i in 1..13 do
      @cards.push(Card.new(suit, i))
    end
  end
  
  def draw_card
    @cards.pop
  end
  
  def deal_cards(number_of_cards)
    dealt_cards = Array.new()
    for i in 1..number_of_cards do
      dealt_cards.push(draw_card)
    end
    dealt_cards
  end
  
  def deal_hand
    deal_cards(2)
  end

end
