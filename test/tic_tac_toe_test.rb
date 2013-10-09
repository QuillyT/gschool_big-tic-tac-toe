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
    assert_equal @game.player1, @game.turn
    assert_kind_of Board, @game.board
    assert_kind_of Player, @game.player1
    assert_kind_of Player, @game.player2
  end

  def test_click_returns_correct_position
    assert_equal 0, @game.convert_position(100, 100)
    assert_equal 8, @game.convert_position(520, 520)
    assert_equal 1, @game.convert_position(275, 110)
  end

  def test_it_switches_turn
    @game.switch_turn
    assert_equal @game.player2, @game.turn
    @game.switch_turn
    assert_equal @game.player1, @game.turn
  end
end
