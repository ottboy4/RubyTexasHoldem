
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
    if number == 1 # high ace
      @number = 14
    elsif number == 0 # low aces - should be only for internal code
      @number = 1
    else
    @number = number
    end
  end
  
  def to_s
    if @number == 11
      "J#{@suit}"
    elsif @number == 12
      "Q#{@suit}"
    elsif @number == 13
      "K#{@suit}"
    elsif @number == 14
      "A#{@suit}"
    else 
      "#{@number}#{@suit}"
    end
  end
  
  def <=> other
    return 0-(self.number <=> other.number)
  end

end