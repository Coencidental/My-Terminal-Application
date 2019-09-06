require_relative '../Classes/card_logic_class'
require 'colorize'
require 'artii'
system('clear')

# This file controls the initial welcoming of a user, the gathering of game arguments, and ensures a loop state is active until the user desires the game to end
artii = Artii::Base.new :font => 'slant', :mode => 'blink'
system('clear')
artii.asciify("> THE    ").colorize(:light_red).each_char { |c| putc c; sleep 0.0025 }
puts " "
artii.asciify("  GREAT <").colorize(:light_gray).each_char { |c| putc c; sleep 0.0025 }
puts " "
artii.asciify("> MENTAL ").colorize(:light_red).each_char { |c| putc c; sleep 0.0025 }
puts " "
artii.asciify("  SNAP < ").colorize(:light_gray).each_char { |c| putc c; sleep 0.0025 }
puts "
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Welcome to Coen Drexler's mental and emotional (inverse) snap, enjoy your game!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
".colorize(:light_red)

loop do
  
  puts "Press E to exit, and anything else to play a game!"
  break if gets.chomp.downcase == 'e'
  system('clear')
  puts "Enter R to read the rules of snap, and anything else to continue."
  readrules = gets.strip
  if (readrules == "R") || (readrules == "r")

    puts "Rules of Snap:

    1: A shuffled deck will be split evenly between you and the computer, your fierce and all knowing opponent.

    2: Whenever you are ready, one card will be removed from each players hand, and displayed simultaneously.

    3: If the cards match either by suit (spades : spades) or by index (ace : ace) depending on which option
       you select, hit enter to 'snap', and if you can do it faster than the computer you will win the round.  
       If the cards DON'T match, don't enter anything, and the round will finish by itself, evaluated as a tie.

    4: If you win, all cards in play since the last win or loss will be placed into the computers hand, and 
       you will be awarded 10 points.

    5: If you lose, all cards in play will be placed in YOUR hand, and you will lose 10 points.

    6: Rounds will repeat until one player reaches 0 cards, and will be declared the winner.

    7: Good luck!  And remember, don't hold back, your computer knows just how quick you can be.

    Whenever you're ready to continue, enter anything.
    "

    loop do
      # Places the user until they have had enough time to read the rules, and breaks when any input occurs
      break if gets
    end
  end
  system('clear')
  puts "What difficulty would you like? 1 for easy, 2 for moderate, and 3 for hard!"
  # Gather player input to determine difficulty argument for game object
  difficulty = gets.strip.to_i
  
  if difficulty == 1
    puts artii.asciify("Easy.  Much like you.").colorize(:light_blue)
  elsif difficulty == 2
    puts artii.asciify("Moderate.. you can do better.").colorize(:light_gray)
  else
    puts artii.asciify("NOW WE-A COOKIN'").colorize(:light_red)
  end
  puts " "
  puts "You can either play by suit pairs (Spades - Spades), or by index pairs (Ace - Ace)"
  sleep(1)
  puts "Enter '1' for suit pairs, and '0' or anything else for normal index pairs"
  gamelogic = (gets.strip.to_i == 1) ? 1 : 0
  # Gather player input to determine game logic argument for game object

  puts artii.asciify("Okay, you selected " + (gamelogic == 1 ? "suit pairs!" : "index pairs!")).colorize(:light_blue)
  sleep(1.5)
  # Initializes a fresh game object with the required arguments, and places the player into a gameplay method
  game = Game.new(difficulty, gamelogic)
  game.play
  system('clear')
end

# end


