require './lib/board'
require './lib/player'
require './lib/boardview'

class TicTacToe
  attr_reader :player1, :player2, :board, :turn, :boardview, :big_game, :game_number
  def initialize(big_game,game_number)
    @big_game = big_game
    @game_number = game_number
    @player1 = big_game.player1
    @player2 = big_game.player2
    @turn = big_game.turn
    @board = Board.new(player1, player2)
    @boardview = BoardView.new(self)
  end

  def length
    big_game.length/3
  end

  def starting_positions
    [ [0,0],
      [length, 0],
      [length*2, 0],
      [0, length], 
      [length, length], 
      [length*2, length], 
      [0, length*2], 
      [length, length*2], 
      [length*2, length*2]  ]
  end

  def mouse_pressed(x,y)
    if winner? || tie?
      return
    end
    position = convert_position(x,y)
    make_move(position)
    if @board.winner?
      boardview.winner(big_game.turn)
    end
    position
  end

  def tie?
    board.tied?
  end

  def convert_position(x,y)
    x = convert_x(x)
    y = convert_y(y)
    coordinate_to_position[[x,y]]
  end

  def convert_x(x)
    if (boardview.x0..boardview.x1).include?(x)
      coord = (boardview.x0+boardview.x1)/2
    end
    if (boardview.x1..boardview.x2).include?(x)
      coord = (boardview.x1+boardview.x2)/2
    end
    if (boardview.x2..boardview.x3).include?(x)
      coord = (boardview.x2+boardview.x3)/2
    end
    return coord
  end

  def convert_y(y)
    if (boardview.y0..boardview.y1).include?(y)
      coord = (boardview.y0+boardview.y1)/2
    end
    if (boardview.y1..boardview.y2).include?(y)
      coord = (boardview.y1+boardview.y2)/2
    end
    if (boardview.y2..boardview.y3).include?(y)
      coord = (boardview.y2+boardview.y3)/2
    end
    return coord
  end

  def x_mids
    {
      0 => (boardview.x0+boardview.x1)/2,
      1 => (boardview.x1+boardview.x2)/2,
      2 => (boardview.x2+boardview.x3)/2,
    }
  end

  def y_mids
    {
      0 => (boardview.y0+boardview.y1)/2,
      1 => (boardview.y1+boardview.y2)/2,
      2 => (boardview.y2+boardview.y3)/2,
    }
  end

  def coordinate_to_position
    {
      [x_mids[0],y_mids[0]] => 0,
      [x_mids[1],y_mids[0]] => 1,
      [x_mids[2],y_mids[0]] => 2,
      [x_mids[0],y_mids[1]] => 3,
      [x_mids[1],y_mids[1]] => 4,
      [x_mids[2],y_mids[1]] => 5,
      [x_mids[0],y_mids[2]] => 6,
      [x_mids[1],y_mids[2]] => 7,
      [x_mids[2],y_mids[2]] => 8,
    }
  end

  def make_move(move)
    unless @board.valid_move?(move)
      return
    end

    if big_game.turn == player1
      boardview.draw_x(coordinate_to_position.invert[move])
    else
      boardview.draw_o(coordinate_to_position.invert[move])
    end

    @board.grid[move] = big_game.turn
    game_number
  end

  def winner?
    @board.winner?
  end

end
