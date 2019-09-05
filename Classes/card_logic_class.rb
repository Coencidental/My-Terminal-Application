require 'timeout'
require 'colorize'
require 'artii'
require_relative 'deck' 


class Game
  def initialize(difficulty, gamelogic)
    @difficulty = 
      # Ensures user input falls within one of 3 inbuilt difficulty settings
      if difficulty == 1
        1
      elsif difficulty == 2
        2
      else 
        3
      end

    # As the logic is a binary argument, it can be assigned to the user input directly
    @gamelogic = gamelogic
    @refdeck = Deck.new()
    @deck_player, @deck_computer = @refdeck.split
    @pot = []
    @round_complete = false
    @points = 0
    @snap = false
    @round_totals_user = []
    @round_totals_computer = []
    @artiivalues = Artii::Base.new :font => 'slant'
  end

  def play
    # This is the main controller method that dictates the flow the the program within the confines of a single game, and only a single game
    while @round_complete == false
      system('clear')
      puts '---------------------------------------------
      '
      puts 'Your card total is currently: ' + @deck_player.count.to_s
      puts 'The computer card total is: ' + @deck_computer.count.to_s
      puts "Whenever you're ready for your cards, enter any character you like, and be ready to hit enter if you want to snap!"
      puts "[Your points: #{@points}]
      "
      puts '---------------------------------------------'
      # Prior to beginning each round, the game will print card totals and point standing
      userinput = gets.strip
      if userinput != ""
        system('clear')
        self.round
        if @deck_player.count == 0 || @deck_computer.count == 0
          @round_complete = true
        end
      else 
        puts "That's an invalid input"     
        # Checks user input to ensure their input is intentional, and also to ensure self.round calls don't stack up unintentionally
      end
    end
    self.announce_winner
  end

  def round
    # Essentially a sub-controller method, called within the primary control loop of the play method, used to control the logic flow for each round increment
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
    # Used to provide a limited, configurable window of time for the user to respond.  Useful for any time restricted application
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
    # Prints both cards simultaneously using internal card draw method
    puts "Your card is: "
    card1.draw
    puts "The computers card is: "
    card2.draw
  end

  def compare(card1, card2)
    # Used to compare a specific attribute of two cards simultaneously, and compare them based on the pre-determined game logic
    if @gamelogic == 0
      return (card1.value == card2.value)
    elsif @gamelogic == 1
      return (card1.suit == card2.suit)
    end
  end

  def analyse_results
    # For each round, uses process of elimination to simply check the results
    if @user_snapped == false
      if @snap == true
        puts @artiivalues.asciify("You Lost!").colorize(:light_red)
        self.computer_win
      else
        puts @artiivalues.asciify("You tied!")
        self.tie
        
      end
    else
       if @snap == true
        puts @artiivalues.asciify("You snapped, and won!").colorize(:light_blue)
        self.user_win
       else
        puts @artiivalues.asciify("You snapped unnecessarily!").colorize(:light_red)
        self.computer_win
       end
    end
  end

  def computer_win
    # Called for each computer win case, adjusts points and cards accordingly, and writes corresponding entries to the 'game results' variable for later review
    @points -= 10
    @pot.each do |x|
      @deck_player << @pot.pop 
    end
    @deck_player << @roundcard_computer
    @deck_player << @roundcard_player
    @round_totals_computer << ["W".colorize(:light_blue)]
    @round_totals_user << ["L".colorize(:red)]
  end

  def user_win
    # Inverse to computer win method
    @points += 10
    @pot.each do |x|
      @deck_computer << @pot.pop
    end
    @deck_computer << @roundcard_computer
    @deck_computer << @roundcard_player
    @round_totals_computer << ["L".colorize(:red)]
    @round_totals_user << ["W".colorize(:light_blue)]
  end

  def tie
    # Places both currently played cards into a pot, and writes a 'tie' entry in to the game results object for later review
    @pot << @roundcard_computer
    @pot << @roundcard_player
    @round_totals_computer << ["T"]
    @round_totals_user << ["T"]
  end

  def announce_winner
    system('clear')
    if @deck_player.count == 0
      # If the user deck is the first to be equal to 0, they will win
      puts "Congratulations!  You won that game!"
    elsif @deck_computer.count == 0
      # Otherwise, the computer must be the winner.
      puts "*sad trombone* You lost that game!"
    end
    puts "Would you like to view the round results of the game?"
    # On confirmation, the user can review the game results tally using an internal method that resets for each game initialization
    if gets.strip.to_i == 1
      self.announce_scores
     else
      puts "Thanks for playing!" 
    end
    sleep(2)
  end

  def announce_scores
    roundcount = @round_totals_computer.count
    roundcount_array = []
    roundcount.times do |x|
      roundcount_array << x + 1
    end
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Bot: " + @round_totals_computer.flatten.join(" - ")
    puts "~~~~~ You won #{@round_totals_user.flatten.count('W'.colorize(:light_blue))} game/s ~~~~~"
    # line 197 includes colorize because otherwise, it doesn't not recognise the W it is passed
    puts "You: " + @round_totals_user.flatten.join(" - ")
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    loop do
      exitscores = gets.strip
      if exitscores != "91m"
        break 
      end   
    end
  end
end

