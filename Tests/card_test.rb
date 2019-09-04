require 'test-unit'
require_relative '../Classes/card_class'

class CompareTest < Test::Unit::TestCase

  def setup
    @card = Card.new("Spades", "Ace")
  end

  def test_match_true
    assert_equal("Ace", @card.value)
  end
  def test_match_false
    assert_equal("Spades", @card.suit)
  end
end