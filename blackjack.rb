# Blackjack
#
# Game
# 1. Have a deck of 52 cards
# 2. Shuffle the cards and make them available one by one from the shoe
# 3. Give 2 cards to the player and 2 cards to the dealer
# 4. Show the player's 2 cards and the first card of the dealer
# 5. Player: give the choice to hit or stay
#   - Hit: deal another card
#       - if greater than 21, player has busted and lost
#       - if 21, player wins
#       - if less than 21, give the choice to the player to hit or stay
#   - Stay: sum the value of the player cards
#   - Show all the player cards
# 6. Dealer: must choose to hit or stay
#   - Same rules as for the player
#   - But under 17, must hit
# 7. Compare the results of the player and dealer
#
# Method to calculate the sum of the cards
# - Numerical cards are worth the values they show
# - Face cards (kings, queens, jacks) are worth 10
# - Aces are worth 1 or 11
# 1. Sum up the values of the cards
# 2. If one card is an ace:
#   a. Make 2 totals, with the ace worth 1 and worth 11
#   b. Take the highest score that is less or equal to 21
# 3. If two or more cards are aces:
#   - same thing, make all possible totals and take the highest score <= 21
# Method: start with Aces worth 11 and calculate the sum, if it is > 21, then calculate again by removing 10, etc, until the sum is <=21, with the constraint: we have one right to remove 10 for each Ace present in the set of cards.
#
# Structure for the deck of cards
# - each card is identified by 2 infos: value and suit
#   - values taken from: Ace, 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King
#   - suits taken from: Clubs, Diamonds, Hearts, Spades
# - the 52 cards deck is a combination of all possibilities of values and suits
# Card examples: ["Ace", :spades], ["2", :diamonds]
# Shoe: [["Ace", :spades], ["2", :diamonds],...]

require "pry"

CARD_VALUES = ["Ace", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
CARD_SUITS = [:clubs, :diamonds, :hearts, :spades]

def create_shoe
  deck = CARD_VALUES.product(CARD_SUITS)
  shoe = deck.shuffle
end

def show_card(card)
  "#{card[0]} of #{card[1]}"
end

def show_hand(hand)
  hand.map do |card|
    show_card(card)
  end.join(", ")
end

def card_value(card)
  case card[0]
  when "Ace"
    return 11
  when "Jack"
    return 10
  when "Queen"
    return 10
  when "King"
    return 10
  else
    return card[0].to_i
  end
end

def number_of_aces(hand)
  hand.select do |card|
    card.include?("Ace")
  end.count
end

def hand_value(hand)
  hand_values = hand.map do |card|
    card_value(card)
  end
  v = hand_values.reduce(:+)
  n = number_of_aces(hand)
  while (v > 21) && (n > 0)
    v = v - 10
    n = n - 1
  end
  return v
end

shoe = create_shoe
player_hand = [shoe.pop, shoe.pop]
dealer_hand = [shoe.pop, shoe.pop]

puts "Dealer first card is: #{show_card(dealer_hand[0])}"
puts "Your cards: #{show_hand(player_hand)}"
# puts "Hit or Stay? (h/s)"
# For the moment, suppose it is always stay for player and dealer and calculate totals

binding.pry
