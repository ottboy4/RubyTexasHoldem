
module Suit
  DIAMOND = 'd'
  HEART = 'h'
  CLUB = 'c'
  SPADE = 's'
end


class Card
  attr_accessor :suit, :number

  def initialize(suit, number)
    @suit = suit
    @number = number
  end

end