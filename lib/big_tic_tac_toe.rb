require './lib/board'
require './lib/player'
require './lib/boardview'
require './lib/tic_tac_toe'
#require 'ruby-processing'

class BigTicTacToe < Processing::App

  attr_reader :player1, :player2, :turn, :board, :games

  def setup
    smooth
    size length, length
    clear_screen
    stroke_weight 5
    setup_game
  end

  def clear_screen
    background(180,180,180)
  end

  def length
    720
  end

  def setup_game
    @player1 = Player.new
    @player2 = Player.new
    @turn = player1
    @board = Board.new(player1,player2)
    @games = Array.new(9)
    @games.each_index{ |index| @games[index] = TicTacToe.new(self,index) }
    draw_board
  end

  def draw_board
    stroke(0,0,50)
    line(length/3, 0, length/3, length)
    line(length/3*2, 0, length/3*2, length)
    line(0, length/3, length,  length/3)
    line(0, length/3*2, length,  length/3*2)
  end

  def draw

  end

  def mouse_pressed
    find_game(mouse_x, mouse_y)
    # determine which game it's at
  end

  def find_game(x,y)
    i = convert_x(x)
    j = convert_y(y)
    @games[coordinate_to_game[[i,j]]].mouse_pressed(x,y)
    puts "game: #{coordinate_to_game[[i,j]]}"
  end

  def convert_x(x)
    if (x0..x1).include?(x)
      coord = 0
    end
    if (x1..x2).include?(x)
      coord = 1
    end
    if (x2..x3).include?(x)
      coord = 2
    end
    return coord
  end

  def convert_y(y)
    if (y0..y1).include?(y)
      coord = 0
    end
    if (y1..y2).include?(y)
      coord = 1
    end
    if (y2..y3).include?(y)
      coord = 2
    end
    return coord
  end

  def x0
    0
  end

  def x1
    240
  end

  def x2
    480
  end

  def x3
    720
  end

  def y0
    0
  end

  def y1
    240
  end

  def y2
    480
  end

  def y3
    720
  end

  def coordinate_to_game
    {
      [0,0] => 0,
      [1,0] => 1,
      [2,0] => 2,
      [0,1] => 3,
      [1,1] => 4,
      [2,1] => 5,
      [0,2] => 6,
      [1,2] => 7,
      [2,2] => 8,
    }
  end

end
