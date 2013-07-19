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
     if value < 10
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
      @player_hands[i-1].folded = choose_to_fold?
    end
  end
  
  def deal_first_table_cards
    for i in 1..@number_of_players
      unless @player_hands[i-1].folded
        @player_hands[i-1].add_cards(@deck.deal_cards(3))
      end
    end
  end
  
  def deal_next_table_card
    for i in 1..@number_of_players
      unless @player_hands[i-1].folded
        @player_hands[i-1].add_cards(@deck.deal_cards(1))
      end
    end
  end
  
  def print_hands
    for i in 1..@number_of_players
      puts @player_hands[i-1].to_s
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
    print_hands
  end
end

TexasHoldem.new.play_game
