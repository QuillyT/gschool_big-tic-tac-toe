require 'ruby-processing'
require './lib/board'
require './lib/player'

class TicTacToe < Processing::App

  attr_reader :turn, :p1, :p2, :board
  # attr_accessor :turn

  def setup
    size 620, 620
    @p1 = Player.new
    @p2 = Player.new

    smooth
    stroke_weight 10
    setup_board
  end

  def draw
  end

  def setup_board
    @turn = p1
    @board = Array.new(9)
    background(255,255,255)
    draw_lines
  end

  def draw_lines
    fill(0, 0, 0)
    line(205, 0, 205, 620)
    line(415, 0, 415, 620)
    line(0, 205, 620, 205)
    line(0, 415, 620, 415)
  end

  def mouse_pressed
    if win_exists? || tie?
      setup_board
      return
    end

    #figure out which square it's in
    if (0..205).include?(mouse_x)
      x_coord = 100
    elsif (206..415).include?(mouse_x)
      x_coord = 310
    else
      x_coord = 520
    end

    if (0..205).include?(mouse_y)
      y_coord = 100
    elsif (206..415).include?(mouse_y)
      y_coord = 310
    else
      y_coord = 520
    end

    make_move(x_coord, y_coord)

    if win_exists?
      background(255,255,255)
      winner(turn)
    end

    if tie?
      background(255,255,255)
      fill(0,0,0)
      ellipse(310,310,600,600)
      fill(255,255,255)
      ellipse(310,310,580,580)
      fill(0,0,0)
      line(10,610,610,10)
      line(10,10,610,610)
    end

    switch_turns

  end

  def tie?
    board.all?
  end

  def coordinate_hash
    {
      [100,100] => 0,
      [310,100] => 1,
      [520,100] => 2,
      [100,310] => 3,
      [310,310] => 4,
      [520,310] => 5,
      [100,520] => 6,
      [310,520] => 7,
      [520,520] => 8,

    }
  end

  def valid_move?(position)
    board[position].nil?
  end

  def make_move(x_coord,y_coord)
    unless valid_move?(coordinate_hash[[x_coord, y_coord]])
      return
    end
    if turn == p1
      draw_X(x_coord,y_coord)
    else
      draw_O(x_coord,y_coord)
    end
    @board[coordinate_hash[[x_coord, y_coord]]] = turn

  end

  def draw_X(x_coord,y_coord)
    fill(0,0,0)
    line(x_coord-90, y_coord-90, x_coord+90,y_coord+90)
    line(x_coord+90, y_coord-90, x_coord-90,y_coord+90)
  end

  def draw_O(x_coord,y_coord)
    fill(0,0,0)
    ellipse(x_coord,y_coord,180,180)
    fill(255,255,255)
    ellipse(x_coord, y_coord, 175, 175)
  end


  def winner(turn)
    if(turn == p1)
      fill(0,0,0)
      line(10,610,610,10)
      line(10,10,610,610)
    else
      fill(0,0,0)
      ellipse(310,310,600,600)
      fill(255,255,255)
      ellipse(310,310,580,580)
    end
  end

  def win_exists?
    winning_spots.find do |set|
      set.all? { |position| board[position]==p1 } || set.all? { |position| board[position]==p2 }
    end
  end

  def winning_spots
    [ [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6] ]
  end

  def switch_turns
    if turn == p1
      @turn = p2
    else
      @turn = p1
    end
  end

end
