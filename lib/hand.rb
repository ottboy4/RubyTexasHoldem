class Hand

  def fill_cards(suit)
    for i = 1 in i <= 13 do
      @cards.push(Card.new(i, suit))
    end
  end

  def score_cards(cards)

  end

  def is_straight?(cards)
    new_cards = cards.sort { |x,y| x.number < y.number} # sort numbers
    enumer = new_cards.enumerator
    while enumer.has
    end

    def is_flush?(cards)
      suit = cards[0].suit
      cards.each do |card|
        if card.suit != suit
          return false
        end
      end
      return true
    end

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
