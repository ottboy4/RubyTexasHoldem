class Hand
  def score_cards(cards)

  end

  def is_straight?(cards)
    cards = Array.new # TODO remove
    # TODO sort cards first
    cards.each do |card|
      #if (is_straight_with_value?(Array.new(cards), ))
    end
  end

  def is_straight_with_value?(cards, value, inc)
    if inc == 5
      return true
    elsif cards.empty?
      return false
    end
    card_to_remove = nil
    cards.each do |card|
      if card.number - value == 1
        card_to_remove = card
        break
      end
    end
    cards.delete(card_to_remove)
    return is_straight_with_value?(cards, value + 1, inc + 1)
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
