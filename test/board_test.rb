gem 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/board.rb'

class BoardTest < Minitest::Test

  def setup
    @b = Board.new(:player1, :player2)
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
    @b.add_move(position,:player)
    assert_equal :player, @b.grid[position]
  end

  def test_clear_resets_board
    @b.add_move(0, :player)
    @b.add_move(1, :player)
    @b.add_move(2, :player)
    @expected[0] = :player
    @expected[1] = :player
    @expected[2] = :player
    assert_equal @expected, @b.grid
    @b.clear
    assert_equal Array.new(9), @b.grid
  end

  def test_move_is_valid
    @b.add_move(0, :player)
    assert_equal true, @b.add_move(1, :player)
    assert_equal true, @b.add_move(2, :player1)
  end

  def test_move_is_invalid
    @b.add_move(0, :player1)
    @b.add_move(0, :player2)
    @expected[0] = :player
  end

  def test_game_is_tied
    (0..8).each do |position|
      @b.add_move(position, :filler)
    end
    assert @b.tied?, "Expected tied? to return true."
  end

  def test_game_is_not_tied
    (0..7).each do |position|
      @b.add_move(position, :filler)
    end
    refute @b.tied?, "Expected tied? to return false."
  end

  def test_game_has_been_won
    (0..2).each do |position|
      @b.add_move(position, :player1)
    end
    assert @b.winner?, "Expected win? to return true."
    (3..5).each do |position|
      @b.add_move(position, :player1)
    end
    assert @b.winner?, "Expected win? to return true."
    (6..8).each do |position|
      @b.add_move(position, :player1)
    end
    assert @b.winner?, "Expected win? to return true."
  end

end
