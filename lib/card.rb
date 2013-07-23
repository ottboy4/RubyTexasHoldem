
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
    if number == 1
      @number = 14
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