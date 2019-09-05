require 'timeout'
require 'colorize'

class Gameplay
  attr_reader :referencedeck
  attr_accessor :playerhand, :computerhand, :suits
  def initialize
    @exit_game = false
    @gameover = false
    @referencedeck = []
    @playerhand = []
    @computerhand = []
    @gameplaydeck = []
    @suits = %w[ Hearts Diamonds Clubs Spades ]
    @snap = false
    @logicstate = 0
  end

  def generate_refdeck
    @suits.each do |x|
      13.times {|y|
        case y
        when 0
          @referencedeck << Card.new(x, "Ace")
        when 1..9
          @referencedeck << Card.new(x, (y + 1).to_s)
        when 10
          @referencedeck << Card.new(x, "Jack")
        when 11
          @referencedeck << Card.new(x, "Queen")
        when 12
          @referencedeck << Card.new(x, "King")
        end 
      }
    end
  end

  def gamebegin
    puts `clear`
    puts "Welcome to Coen Drexler's mental and existential snap!"
    sleep(0.5)
    puts "-----"
    sleep(0.5)
    while @exit_game == false
      @gameplaydeck = @referencedeck.shuffle
      self.cards_sort(@gameplaydeck)
      puts "Whenever you're ready to play, enter 1, and to exit enter E"
      input = gets.strip.chomp
      case input
        when '1' || 1
          puts "You can either play by suit (Spades - Spades) pairs, or by index (Ace - Ace) pairs"
          sleep(1)
          puts "Enter 'S' for suit pairs, and 'I' or anything else for normal index pairs"
          gets.strip.chomp == 'S' ? @logicstate = 1 : @logicstate = 0
          puts (@logicstate == 1 ? "Okay, special suit pairs it is!" : "Normal index pairs it is!")
          @playerpoints = 0
          @computerpoints = 0
          @pot = []
          while @gameover == false
            sleep(1)
            self.startsnap
          end
        when 'E' || 'e'
          @exit_game = true
        else 
          puts "Invalid input"
      end
      end
  end

  def cards_sort(x)
    26.times do |a|
      @playerhand << x.pop
    end 
    26.times do |a|
      @computerhand << x.pop
    end
  end

  def startsnap
    roundcomplete = false
    while roundcomplete == false
      puts "--------------------------------------
      Okay, whenever you feel ready, enter 1
      --------------------------------------"
      puts "
        Your cards: #{@playerhand.count}
        Computer's cards: #{@computerhand.count}
        "
      if gets.chomp == '1'
        puts `clear`
        @roundcardcomputer = nil
        @roundcarduser = nil
        @roundcardcomputer = @computerhand.pop
        @roundcarduser = @playerhand.pop
        puts "Computer: #{drawcard(@roundcardcomputer)}"
        
        
        puts "You: #{drawcard(@roundcarduser)}"
        randvalue = rand((0.45)..(1))
        begin
          @userinput = Timeout::timeout(randvalue) do
            gets
          end
        rescue Timeout::Error
          @userinput = false
        end

        self.cardcomparison(@roundcardcomputer,@roundcarduser)
        if @userinput != false
          if @snap == true
            puts "User:  SNAP"
            puts "You won!"
            @playerpoints += 10
            @computerpoints -= 10
            self.readpoints
            sleep(0.5)
            @pot.each do |a|
              @computerhand << @pot.pop
            end
            @pot = []



          elsif @snap == false
            puts "They didn't match sorry!"
            @playerpoints -= 10
            @computerpoints += 10
            if @pot.count > 0
              @pot.each {|a|
                @playerhand << a
              }
              @pot = []
            end
            @playerhand << @roundcardcomputer
            @playerhand << @roundcarduser      
            @playerhand.shuffle!
            self.readpoints      
          end
          
        else
          if @snap == true
            @computerpoints += 10
            @playerpoints -= 10
            puts "Computer: SNAP"
            @pot.each {|a|
              @playerhand << a
            }
            @playerhand << @roundcardcomputer
            @playerhand << @roundcarduser
            self.readpoints
          else 
            puts "This round was a tie!"
            @pot << @roundcardcomputer
            @pot << @roundcarduser
            puts @pot
            self.readpoints
          end
        end
        if @playerhand == 0 || @computerhand == 0
          @gameover = true
        else
        
        end
      else
          puts "Invalid input sorry, put 1 to play"
      end
    end

  end

  def drawcard(a) 
    drawsuit = nil
    drawvalue = nil
    case a.suit
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

    case a.value
    when "Ace"
      drawvalue = "A "
    when 10 || '10'
      drawvalue = a.value.to_s
    when "Jack"
      drawvalue = "J "
    when "Queen"
      drawvalue = "Q "
    when "King"
      drawvalue = "K "
    else
      drawvalue = a.value.to_s + " "
    end

    puts "
    ______
    |#{drawvalue}   |
    |     |
    |     |
    |#{drawsuit}____|
    "
    
  end

  def readpoints
    puts "User: #{@playerpoints.to_s} points!"
    puts "Computer: #{@computerpoints.to_s} points!
    "
  end

  def cardcomparison(a,b)

    if @logicstate == 0
      if a.value == b.value
        @snap = true
      else 
        @snap = false
      end

    elsif @logicstate == 1
      if a.suit == b.suit
        @snap = true
      else
        @snap = false
      end
    end
  end
end

class Card
  attr_reader :suit, :value

  def initialize(suit,value)
    @suit = suit
    @value = value
  end
end

game = Gameplay.new
game.generate_refdeck
game.gamebegin