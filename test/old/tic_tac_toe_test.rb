gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/tic_tac_toe.rb'

class TicTacToeTest < Minitest::Test

  def setup
    @game = TicTacToe.new
  end

  def test_it_exists
    assert_kind_of TicTacToe, @game
  end

  def test_it_initializes_correctly
    assert_equal @game.p1, @game.turn
    assert_kind_of Board, @game.board
    assert_kind_of Player, @game.p1
    assert_kind_of Player, @game.p2
  end
end


