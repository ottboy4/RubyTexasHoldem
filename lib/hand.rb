class HandRank

  attr_accessor :first_compare, :second_compare, :third_compare, :fourth_compare, :fifth_compare, :sixth_compare, :value
  def initialize
    @first_compare = 0
    @second_compare = 0
    @third_compare = 0
    @fourth_compare = 0
    @fifth_compare = 0
    @sixth_compare = 0
    @value = 0
  end

  def calc_value
    @value = @sixth_compare
    @value += @fifth_compare * 100
    @value += @fourth_compare * 10000
    @value += @third_compare * 1000000
    @value += @second_compare * 100000000
    @value += @first_compare * 10000000000

  end

  def <=> other
    calc_value
    other.calc_value
    puts self.value
    puts other.value
    return self.value <=> other.value
  end

end

class Hand

  attr_accessor :folded
  attr_accessor :hand_type
  def initialize(cards)
    @hand_rank = HandRank.new
    @cards = cards
    @cards.sort!
    @card_sets = nil
    get_card_sets
    @folded = false
    @hand_type = ''
  end

  def to_s
    "#{@cards.to_s} #{@hand_type}"
  end

  def add_cards(cards)
    @cards.concat(cards)
    @cards.sort!
    get_card_sets
  end

  def fold
    @folded = true
  end

  def get_card_sets
    @card_sets = Hash.new
    temp_cards = Array.new(@cards)
    @cards.each do |card|
      cards_of_num = temp_cards.select { |c| c.number == card.number }
      if (cards_of_num.length > 0)
        @card_sets.store(card.number, cards_of_num)
      end
      temp_cards.delete_if { |c| c.number == card.number }
    end
    @card_sets = Hash[@card_sets.sort_by { |_, v| 0-v.length }]
  end

  def score_cards
    best = royal_flush
    if(best == nil)
      best = straight_flush
      if(best == nil)
        best = four_of_a_kind
        if (best == nil)
          best = full_house
          if(best == nil)
            best = flush
            if(best == nil)
              best = straight
              if(best == nil)
                best = three_of_a_kind
                if(best == nil)
                  best = two_pair
                  if(best == nil)
                    best = pair
                    if(best == nil)
                      best = high_card
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    best
  end

  def royal_flush
    @card_sets = Hash.new
    temp_cards = Array.new(@cards)
    temp_cards.keep_if {|card| card.number > 9}
    @cards.each do |card|
      if(card.number > 9)
        cards_of_num = temp_cards.select { |c| c.number == card.number }
        @card_sets.store(card.number, cards_of_num)
        temp_cards.delete_if { |c| c.number == card.number }
      end
    end
    @card_sets = Hash[@card_sets.sort_by { |_, v| 0-v.length }]
    for i in 0..4
      if(@card_sets.keys[i] != 14-i)
        get_card_sets
        return nil
      end
    end
    exists = 15
    for i in 0..4
      card_exists = 0
      @card_sets[14-i].each do |card|
        if(card.suit == Suit::DIAMOND)
        card_exists = card_exists | 8
        elsif(card.suit == Suit::HEART)
        card_exists = card_exists | 4
        elsif(card.suit == Suit::CLUB)
        card_exists = card_exists | 2
        elsif(card.suit == Suit::SPADE)
        card_exists = card_exists | 1
        end
      end
      exists = exists & card_exists
    end
    get_card_sets
    if(card_exists > 0)
      @hand_type = "Royal Flush"
      @hand_rank.first_compare = Values::ROYAL_FLUSH
    return @hand_rank
    else
      return nil
    end
  end

  def straight_flush
    my_cards = Array.new(@cards)
    my_cards.select {|card| card.number == 14 }.each {|card| my_cards.push(Card.new(card.suit, 0)) } # add all aces as 1's also keeping the suit information
    my_cards.each do |card|
      cards_of_suit = my_cards.select { |c| c.suit == card.suit }
      if cards_of_suit.length >= 5 # only if there are at least 5 cards with the same suit
        high_card = straight_high_card_value(cards_of_suit)
        if high_card != nil
          @hand_type = "Straight Flush"
          @hand_rank.first_compare = Values::STRAIGHT_FLUSH
          @hand_rank.second_compare = high_card
          return @hand_rank
        end
      end
      my_cards.delete_if { |c| c.suit == card.suit }
    end
    nil # no straight flush found, return nil
  end

  # checks to see if all the passed in cards are of the same suit
  def flush?(cards)
    suit = cards[0].suit
    cards.each do |card|
      return false if card.suit != suit
    end
    true
  end

  def four_of_a_kind
    if(@card_sets.values[0].length == 4)
      @hand_rank.first_compare = Values::FOUR_OF_A_KIND
      @hand_rank.second_compare = @card_sets.keys[0]
      other_cards = Array.new(@cards)
      other_cards.keep_if {|card| card.number != @card_sets.keys[0]}
    @hand_rank.third_compare = other_cards[0].number
    @hand_type = "Four of a kind"
    return @hand_rank
    end
  end

  def full_house
    has_three = false
    @card_sets.each do |card_value, cards|
      if(has_three)
        if (cards.length > 1)
          @hand_rank.first_compare = Values::FULL_HOUSE
        @hand_rank.second_compare = @card_sets.keys[0]
        @hand_rank.third_compare = @card_sets.keys[1]
        @hand_type = "Full House"
        return @hand_rank
        else
          return nil
        end
      elsif cards.length == 3
      has_three = true
      else
        return nil
      end
    end
  end

  def flush
    card_exists = 0
    @cards.each do |card|
      if(card.suit == Suit::DIAMOND)
      card_exists = card_exists += 1
      elsif(card.suit == Suit::HEART)
      card_exists = card_exists += 10
      elsif(card.suit == Suit::CLUB)
      card_exists = card_exists += 100
      elsif(card.suit == Suit::SPADE)
      card_exists = card_exists += 1000
      end
    end
    spade_flush = card_exists/1000 > 4
    club_flush = (card_exists%1000)/100 > 4
    heart_flush = (card_exists%100)/10 > 4
    diamond_flush = card_exists%10 > 4
    if(spade_flush || club_flush || heart_flush || diamond_flush)
      @hand_rank.first_compare = Values::FLUSH
      suit_cards = Array.new(@cards)
      if(spade_flush)
        suit_cards.keep_if {|card| card.suit == Suit::SPADE }
      elsif(club_flush)
        suit_cards.keep_if {|card| card.suit == Suit::CLUB }
      elsif(heart_flush)
        suit_cards.keep_if {|card| card.suit == Suit::HEART }
      elsif(diamond_flush)
        suit_cards.keep_if {|card| card.suit == Suit::DIAMOND }
      end
    @hand_rank.second_compare = suit_cards[0].number
    @hand_rank.third_compare = suit_cards[1].number
    @hand_rank.fourth_compare = suit_cards[2].number
    @hand_rank.fifth_compare = suit_cards[3].number
    @hand_rank.sixth_compare = suit_cards[4].number
    @hand_type = "Flush"
    return @hand_rank
    end
    return nil
  end

  def straight
    high_card = straight_high_card_value(@cards)
    if high_card != nil
      @hand_type = "Straight"
      @hand_rank.first_compare = Values::STRAIGHT
      @hand_rank.second_compare = high_card
      return @hand_rank
    end
    nil
  end

  def straight_high_card_value(cards)
    unique = cards.uniq { |x| x.number }
    unique.push(Card.new('e', 0)) if !unique.select {|x| x.number == 14 }.empty? # if selecting all cards with 14 is not empty, add 1 as well to check for straight
    unique.sort!
    valid_so_far = 1
    (1..unique.length - 1).each do |i|
      if unique[i-1].number - unique[i].number == 1
        valid_so_far += 1
      else
        valid_so_far = 1
      end

      if valid_so_far == 5
        return unique[i-4].number # return highest card value
      end
    end
    nil # no straight found, return null (nil)
  end

  def three_of_a_kind
    if(@card_sets.values[0].length == 3)
      @hand_rank.first_compare = Values::THREE_OF_A_KIND
      @hand_rank.second_compare = @card_sets.keys[0]
      other_cards = Array.new(@cards)
      other_cards.keep_if {|card| card.number != @card_sets.keys[0]}
    @hand_rank.third_compare = other_cards[0].number
    @hand_rank.fourth_compare = other_cards[1].number
    @hand_type = "Three of a kind"
    return @hand_rank
    else
      return nil
    end
  end

  def two_pair
    if(@card_sets.values[0].length == 2 && @card_sets.values[1].length == 2)
      @hand_rank.first_compare = Values::TWO_PAIR
      @hand_rank.second_compare = @card_sets.keys[0]
      @hand_rank.third_compare = @card_sets.keys[1]
      other_cards = Array.new(@cards)
      other_cards.keep_if {|card| card.number != @card_sets.keys[0] && card.number != @card_sets.keys[1]}
    @hand_rank.fourth_compare = other_cards[0].number
    @hand_type = "Two pair"
    return @hand_rank
    else
      return nil
    end
  end
  
  def count
    @cards.count
  end

  def pair
    if(@card_sets.values[0].length == 2)
      @hand_rank.first_compare = Values::ONE_PAIR
    @hand_rank.second_compare = @card_sets.keys[0]
    @hand_rank.third_compare = @card_sets.keys[1]
    @hand_rank.fourth_compare = @card_sets.keys[2]
    @hand_rank.fifth_compare = @card_sets.keys[3]
    @hand_type = "Pair"
    return @hand_rank
    end
  end

  def high_card
    @hand_rank.first_compare = @cards[0].number
    @hand_rank.second_compare = @cards[1].number
    @hand_rank.third_compare = @cards[2].number
    @hand_rank.fourth_compare = @cards[3].number
    @hand_rank.fifth_compare = @cards[4].number
    @hand_type = "High card"
    return @hand_rank
  end
end

module Values
  ROYAL_FLUSH = 27
  STRAIGHT_FLUSH = 26
  FOUR_OF_A_KIND = 25
  FULL_HOUSE = 24
  FLUSH = 23
  STRAIGHT = 22
  THREE_OF_A_KIND = 21
  TWO_PAIR = 20
  ONE_PAIR = 19
end
