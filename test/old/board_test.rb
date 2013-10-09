gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board.rb'

class BoardTest < Minitest::Test

  def setup
    @b = Board.new
    @expected = Array.new(9)
  end

  def test_it_exists
    assert_kind_of Board, @b
  end

  def test_it_is_setup_correctly
    empty_board = Array.new(9)
    assert_equal empty_board, @b.grid
  end

  def test_it_execute_a_move
    position = 0
    @b.execute_move(position,:player)
    assert_equal :player, @b.grid[position]
  end

  def test_clear_resets_board
    @b.execute_move(0, :player)
    @b.execute_move(1, :player)
    @b.execute_move(2, :player)
    @expected[0] = :player
    @expected[1] = :player
    @expected[2] = :player
    assert_equal @expected, @b.grid
    @b.clear
    assert_equal Array.new(9), @b.grid
  end

  def test_move_is_valid
    @b.execute_move(0, :player)
    assert_equal true, @b.execute_move(1, :player)
    assert_equal true, @b.execute_move(2, :player1)
  end

  def test_move_is_invalid
    @b.execute_move(0, :player1)
    @b.execute_move(0, :player2)
    @expected[0] = :player

  end

end
