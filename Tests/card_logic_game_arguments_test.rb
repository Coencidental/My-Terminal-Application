require_relative '../Classes/card_logic_class'
require 'test-unit'

require 'test-unit'
require_relative '../Classes/card_class'

class GameInitializeTest < Test::Unit::TestCase

  def setup
    @game = Game.new(1,0)
    @game2 = Game.new(1,1)
    @game3 = Game.new(2,1)
    @game4 = Game.new(3,1)
  end

  def test_gamelogic
    assert_equal(0, @game.gamelogic)
    assert_equal(1, @game2.gamelogic)
  end
  def test_gamedifficulty
    assert_equal(1, @game2.difficulty)
    assert_equal(2, @game3.difficulty)
    assert_equal(3, @game4.difficulty)
  end
end

