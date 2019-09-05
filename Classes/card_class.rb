require 'colorize'

class Card
  attr_reader :suit, :value

  def initialize(suit,value)
    @suit = suit
    @value = value
  end

  def draw
    puts "---------------------"
    puts "#{@value} of #{@suit}"
    drawsuit, drawvalue = drawcardvalues(@value, @suit)
    puts "
    ______
    |#{drawvalue}   |
    |     |
    |     |
    |____#{drawsuit}|
    "
  end

  def drawcardvalues(a, b)
    # Called using both currently played cards, and will check both attributes, then draw a corresponding character for both. 

    
    case a
    when 'Ace'
      drawvalue = "A "
    when *(2..9).map(&:to_s)
      drawvalue = a.to_s + " "
    when '10'
      drawvalue = a.to_s
    when 'Jack'
      drawvalue = "J "
    when 'Queen'
      drawvalue = "Q "
    when 'King'
      drawvalue = "K "
    else
      drawvalue = '? '
    end

    case b
    when "Clubs"
        uni = "\u2667"
        drawsuit = "#{(uni.encode('utf-8')).colorize(:white)}" 
    when "Diamonds"
        uni = "\u2666"
        drawsuit = "#{(uni.encode('utf-8')).colorize(:red)}"
    when "Spades"
        uni = "\u2664"
        drawsuit = "#{(uni.encode('utf-8')).colorize(:white)}"
    when "Hearts"
        uni = "\u2665"
        drawsuit = "#{(uni.encode('utf-8')).colorize(:red)}"
    end

    return [drawsuit, drawvalue]
  end

  
  
end