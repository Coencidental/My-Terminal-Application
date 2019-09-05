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
Welcome to Coen Drexler's mental and emotional snap, enjoy your stay!
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
".colorize(:light_red)
loop do
  
  puts "Press E to exit, and anything else to play a game of snap"
  break if gets.chomp.downcase == 'e'
  system('clear')
  puts "Enter R to read the rules of snap, and anything else to continue"
  if gets.strip == ("R" || "r")
    puts "Rules of snap"
    loop do
      break if gets
    end
  end
  puts "What difficulty would you like? 1 for easy, 2 for moderate, and 3 for hard"
  # Using player input to determine difficulty argument for game object
  difficulty = gets.strip.to_i
  
  if difficulty == 1
    puts artii.asciify("Easy.  Just like you.")
  elsif difficulty == 2
    puts artii.asciify("Moderate.. you can do better.")
  else
    puts artii.asciify("NOW WE-A COOKIN'")
  end
  puts " "
  puts "You can either play by suit (Spades - Spades) pairs, or by index (Ace - Ace) pairs"
    # Using player input to determine game logic argument for game object
  sleep(1)
  puts "Enter '1' for suit pairs, and '0' or anything else for normal index pairs"
  gamelogic = (gets.strip.to_i == 1) ? 1 : 0
  puts artii.asciify("Okay, you selected " + (gamelogic == 1 ? "suit pairs!" : "index pairs!"))
  sleep(1.5)
  # Intitialises game object with required arguments, until game has finished
  game = Game.new(difficulty, gamelogic)
  game.play
  system('clear')
end

# end


