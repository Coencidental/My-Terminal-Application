require_relative 'card_class'

class Deck
  attr_reader :cards

  def initialize
    new_deck
  end

  def new_deck
    suits = %w[ Hearts Diamonds Clubs Spades ]
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
  end

  def split
    return [@cards[0, 26], @cards[26, 26]]
  end 
end
