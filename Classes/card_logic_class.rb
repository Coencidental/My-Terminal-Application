require 'timeout'
require_relative 'deck' 


class Game
  def initialize(difficulty, gamelogic)
    @difficulty = 
      if difficulty == 1
        1
      elsif difficulty == 2
        2
      else 
        3
      end
    
    @gamelogic = gamelogic
    @refdeck = Deck.new()
    @deck_player, @deck_computer = @refdeck.split
    @pot = []
    @round_complete = false
    @points = 0
    @snap = false

  end

  def play

    while @round_complete == false
      system('clear')
      p 'Your card total is: ' + @deck_player.count.to_s
      p 'The computer card total is: ' + @deck_computer.count.to_s
      p "Whenever you're ready for your cards, enter 1"
      p "[Your points: #{@points}]"
      userinput = gets.strip.to_i
      if userinput == 1
        system('clear')
        self.round 
        if @deck_player.count == 0 || @deck_computer.count == 0
          @round_complete = true
        end
      else 
        puts "Invalid input"     
      end
    end
    self.announce_winner
  end

  def round
    @user_snapped = false
    @roundcard_player = @deck_player.pop
    @roundcard_computer = @deck_computer.pop
    draw(@roundcard_player, @roundcard_computer)
    @snap = compare(@roundcard_player, @roundcard_computer)
    self.react
    self.analyse_results
    sleep(1)
    
  end

  def react
    begin
      @random_number = 
        if @snap == true
          if @difficulty == 1
            rand((1 / @difficulty)..(2 / @difficulty))
          elsif @difficulty == 2
            rand((1.2 / @difficulty)..(3 / @difficulty))
          else 
            rand((1.2 / @difficulty)..(3 / @difficulty))
          end
        else  
          1
        end


      @user_snapped = Timeout::timeout((@random_number)) do
        gets
      end
    rescue Timeout::Error
      @user_snapped = false
    end
  end

  def draw(card1, card2)
    puts "Your card is: "
    card1.draw
    puts "The computers card is: "
    card2.draw
  end

  def compare(card1, card2)
    if @gamelogic == 0
      return (card1.value == card2.value)
    elsif @gamelogic == 1
      return (card1.suit == card2.suit)
    end
  end

  def analyse_results
    if @user_snapped == false
      if @snap == true
        puts "You Lost! :("
        self.computer_win
      else
        self.tie
      end
    else
       if @snap == true
        puts "You snapped, and won"
        self.user_win
       else
        puts "You snapped unnecessarily!"
        self.computer_win
       end
    end
  end

  def computer_win
    @points -= 10
    @pot.each do |x|
      @deck_player << @pot.pop 
    end
    @deck_player << @roundcard_computer
    @deck_player << @roundcard_player
  end

  def user_win
    @points += 10
    @pot.each do |x|
      @deck_computer << @pot.pop
    end
    @deck_computer << @roundcard_computer
    @deck_computer << @roundcard_player
  end

  def tie
    puts "It's a tie!"
    @pot << @roundcard_computer
    @pot << @roundcard_player
  end

  def announce_winner
    system('clear')
    if @deck_player.count == 0
      puts "Congratulations!  You won that game!"
    elsif @deck_computer.count == 0
      puts "*sad trombone* You lost that game!"
    end
    sleep(2)
  end

end


# test = Game.new(2, 1)
# test.play