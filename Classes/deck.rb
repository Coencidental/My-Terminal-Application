require_relative 'card_class'

class Deck
  attr_reader :cards

  def initialize
    new_deck
  end

  def new_deck
    suits = %w[ Hearts Diamonds Clubs Spades ]
    # For each 4 suits, which it assigns as a string, this method will create 13 cards, and assign them the appropriate index term based on the integer 
    @cards = suits.map do |x|
      13.times.map do |y|
        case y
        when 0
          Card.new(x, "Ace")
        when 1..9
          Card.new(x, (y + 1).to_s)
        when 10
          Card.new(x, "Jack")
        when 11
          Card.new(x, "Queen")
        when 12
          Card.new(x, "King")
        end 
      end
    end.flatten.shuffle
    # Flatten and shuffle deck on access
  end

  def split
    return [@cards[0, 26], @cards[26, 26]]
    # First 26 cards are assigned to one player deck, 26 cards to the second deck.
  end 
end
