
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
  
  def to_s
    if @number == 11
      "J#{@suit}"
    elsif @number == 12
      "Q#{@suit}"
    elsif @number == 13
      "K#{@suit}"
    elsif @number == 1
      "A#{@suit}"
    else 
      "#{@number}#{@suit}"
    end
  end

end