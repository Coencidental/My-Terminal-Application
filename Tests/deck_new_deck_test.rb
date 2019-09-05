require_relative '../Classes/deck'
require 'test-unit'

class DeckTest < Test::Unit::TestCase

  def setup
    @deck = Deck.new
  end

  def test_new_deck
    assert_equal(@deck.cards.count, 52)
  end
end