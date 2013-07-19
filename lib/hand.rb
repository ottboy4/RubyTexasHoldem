class Hand
  
    attr_accessor :folded
  
  def initialize(cards)
    @cards = cards
    @folded = false 
  end
  
  def to_s
    @cards.to_s
  end
  
  def add_cards(cards)
    @cards.concat(cards)
  end

  def score_cards
    [straight_score, find_matches, flush_score].max
  end
  
  def fold
    @folded = true
  end

  def find_matches
    score = 0
    found_pair = false
    @cards.each do |card|
      cards_of_num = @cards.select { |c| c.number == card.number }
      temp_score = 0
      if cards_of_num.length == 4
        return Values::FOUR_OF_A_KIND * cards_of_num[0].number # returns the four of a kind cause that is the best
      elsif cards_of_num.length == 3
        if found_pair # then full house baby!
          return Values::FULL_HOUSE * cards_of_num[0].number # full house multiplying by the 3 of a kind
        else
          temp_score = Values::THREE_OF_A_KIND * cards_of_num[0].number # 3 of a kind,
          found_pair = false
        end
      elsif cards_of_num.length == 2
        if found_pair
          last_pair_val = score / Values::ONE_PAIR
          new_pair_val = cards_of_num[0].number
          larger = [last_pair_val, new_pair_val].max
          smaller = [last_pair_val, new_pair_val].min
          temp_score = Values::TWO_PAIR * larger + Values::ONE_PAIR * smaller
          found_pair = false
        else
          found_pair = true
          temp_score = Values::ONE_PAIR * cards_of_num[0].number
        end
      end
      if temp_score > score
        score = temp_score
      end
    end
    score
  end

  def straight_score
    @cards.permutation do |diff_cards|
      found = Array.new
      diff_cards.each do |card|
        if card.number - value == 1
          found.push(card)
        else
          found = Array.new
        end
        value = card.number
      end
      if found.length >= 5
        score = 0
        if flush(found)
          score = Values::STRAIGHT_FLUSH
        else
          score = Values::STRAIGHT
        end
        found = found.sort { |x,y| x.number <=> y.number }
        score *= found[4].number # multiply by the largest found
        return score
      end
    end
  end

  def flush_score
    @cards.permutation(5) do |cards|
      if flush?(cards)
        cards = cards.sort { |x,y| x.number <=> y.number }
        return Values::FLUSH * found[4].number
      end
    end
  end

  def flush?(cards)
    suit = cards[0].suit
    cards.each do |card|
      return false if card.suit != suit
    end
    true
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
  ONE_PAIR = 100
end
