require_relative 'lib/hand.rb'
require_relative 'lib/card.rb'

@cards = Array.new

#card = Card.new(Suit::CLUB, 1)
#@cards.push(card)
#card = Card.new(Suit::SPADE, 7)
#@cards.push(card)
#card = Card.new(Suit::DIAMOND, 6)
#@cards.push(card)
#card = Card.new(Suit::HEART, 9)
#@cards.push(card)
#card = Card.new(Suit::HEART, 3)
#@cards.push(card)
#card = Card.new(Suit::HEART, 11)
#@cards.push(card)
#card = Card.new(Suit::HEART, 2)
#@cards.push(card)

card = Card.new(Suit::HEART, 5)
@cards.push(card)
card = Card.new(Suit::SPADE, 7)
@cards.push(card)
card = Card.new(Suit::DIAMOND, 6)
@cards.push(card)
card = Card.new(Suit::HEART, 1)
@cards.push(card)
card = Card.new(Suit::HEART, 2)
@cards.push(card)
card = Card.new(Suit::HEART, 3)
@cards.push(card)
card = Card.new(Suit::HEART, 4)
@cards.push(card)

@hand = Hand.new(@cards)
puts @hand.score_cards.calc_value