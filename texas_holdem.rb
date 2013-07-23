require_relative 'lib/deck.rb'
require_relative 'lib/hand.rb'
class TexasHoldem
  
  def initialize
    @number_of_players = 6
    @player_hands = Array.new
    @deck = Deck.new
  end
  
  def choose_to_fold?
     value = rand(100)
     if value < 15
       return true
     else
       return false
     end
  end
  
  def deal_initial_hand
    for i in 1..@number_of_players
      @player_hands.push(Hand.new(@deck.deal_hand))
    end
  end
  
  def calculate_folded_players
    for i in 1..@number_of_players
      unless @player_hands[i-1].folded
       @player_hands[i-1].folded = choose_to_fold?
      end
    end
  end
  
  def deal_first_table_cards
    cards = @deck.deal_cards(3)
    for i in 1..@number_of_players
      unless @player_hands[i-1].folded
        @player_hands[i-1].add_cards(cards)
      end
    end
  end
  
  def deal_next_table_card
    cards = @deck.deal_cards(1)
    for i in 1..@number_of_players
      unless @player_hands[i-1].folded
        @player_hands[i-1].add_cards(cards)
      end
    end
  end
  
  def print_hands
    for i in 1..@number_of_players
      if i-1 == @winner_index
        puts "#{@player_hands[@winner_index].to_s} (Winner)"
      else 
        puts @player_hands[i-1].to_s
      end
    end
  end
  
  def calculate_winner
    winner_score = 0
    @winner_index = 0
    for i in 1..@number_of_players
      unless @player_hands[i-1].count < 7
        temp = @player_hands[i-1].score_cards.calc_value
        if temp > winner_score
          winner_score = temp
          @winner_index = i-1
        end
      end
    end
  end
  
  def play_game
    deal_initial_hand
    calculate_folded_players
    deal_first_table_cards
    calculate_folded_players
    deal_next_table_card
    calculate_folded_players
    deal_next_table_card
    calculate_winner
    print_hands
  end
end

TexasHoldem.new.play_game
