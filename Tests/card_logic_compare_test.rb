require 'test-unit'
require_relative '../Classes/card_logic_class'
require_relative '../Classes/card_class'

class CardTest < Test::Unit::TestCase

  def setup
    @game = Game.new(1,1)
    @game2 = Game.new(1,0)
    @card = Card.new("Spades", "Ace")
    @card2 = Card.new("Spades", "2")
    @card3 = Card.new("Diamonds", "2")
  end

  def test_suit_matching
    assert_equal(true, @game.compare(@card, @card2))
  end

  def test_suit_unmatched
    assert_equal(false, @game.compare(@card2, @card3))
  end

  def test_index_matching
    assert_equal(true, @game2.compare(@card2, @card3))
  end

  def test_index_unmatched
    assert_equal(false, @game2.compare(@card, @card2))
  end
end