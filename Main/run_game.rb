require_relative '../Classes/card_logic_class'

system('clear')

p "Welcome to Coen Drexler's mental and emotional snap"

loop do
  p "Press E to exit, and anything else to play a game of snap"
  break if gets.chomp.downcase == 'e'
  sleep(1)
  p "What difficulty would you like? 1 for easy, 2 for moderate, and 3 for hard"
  difficulty = gets.strip.to_i
  if difficulty == 1
    puts "Easy.  Just like you."
  elsif difficulty == 2
    puts "Moderate.  You can do better."
  else
    puts "NOW WE-A COOKIN'"
  end
  puts " "
  puts "You can either play by suit (Spades - Spades) pairs, or by index (Ace - Ace) pairs"
  sleep(1)
  puts "Enter '1' for suit pairs, and '0' or anything else for normal index pairs"
  gamelogic = (gets.strip.to_i == 1) ? 1 : 0
  puts "Okay, you selected " + (gamelogic == 1 ? "suit pairs!" : "index pairs!")
  sleep(1.5)
  game = Game.new(difficulty, gamelogic)
  game.play
  system('clear')
end

# end


