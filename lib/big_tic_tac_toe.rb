require './lib/board'
require './lib/player'
require './lib/boardview'
require './lib/tic_tac_toe'
#require 'ruby-processing'

class BigTicTacToe < Processing::App

  attr_reader :player1, :player2, :board, :games, :previous_move
  attr_accessor :turn
  def setup
    smooth
    size length, length
    stroke_weight 5
    @player1 = Player.new
    @player2 = Player.new
    setup_game
    @previous_move = nil 
  end

  def clear_screen
    background(180,180,180)
  end

  def length
    720
  end

  def setup_game
    clear_screen
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
    if winner? || tie?
      setup_game
      return
    end

    game = find_game(mouse_x, mouse_y)

    if valid_game?(game)
      @previous_move = game.mouse_pressed(mouse_x, mouse_y)
      puts "\n\nturn: #{turn.object_id}"
      if board.grid[@previous_move].nil?
        puts "next_move: #{@previous_move}"
      else
        puts "next_move: any"
      end
       


      if previous_move
        if game.winner?
          @board.add_move(game.game_number, turn)
        end
        if winner?
          winner(turn)
        end
        if tie?
          tied_game
        end
        switch_turns
      end
    end
  end

  def valid_game?(game)

    if @previous_move.nil?
      #first move
      return true
    end

    if board.grid[@previous_move].nil?
      if @previous_move == game.game_number
        #correct game for previous move
        return true
      end
    else
      true
    end

  end

  def tied_game
    stroke_weight 20
    turn == player1
    stroke(100,0,0)
    line(x0+shift,y3-shift,x3-shift,y0+shift)
    line(x0+shift,y0+shift,x3-shift,y3-shift)
    stroke(0,100,0)
    no_fill()
    arc((x0+x3)/2,(y0+y3)/2,length-shift,length-shift,0,2*Math::PI)
    stroke_weight 5
  end

  def tie?
    @board.tied?
  end

  def winner(turn)
    stroke_weight 20
    if turn == player1
      stroke(100,0,0)
      line(x0+shift,y3-shift,x3-shift,y0+shift)
      line(x0+shift,y0+shift,x3-shift,y3-shift)
    else
      stroke(0,100,0)
      no_fill()
      arc((x0+x3)/2,(y0+y3)/2,length-shift,length-shift,0,2*Math::PI)
    end
    stroke_weight 5
  end


  def winner?
    @board.winner?
  end

  def mouse_released
    # switch "highlight" to required game
  end

  def find_game(x,y)
    i = convert_x(x)
    j = convert_y(y)
    @games[coordinate_to_game[[i,j]]]
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

  def switch_turns
    if turn == player1
      @turn = player2
    else
      @turn = player1
    end
  end

  def shift
    length/30
  end

  def x0
    0
  end

  def x1
    x0+(length/3)
  end

  def x2
    x0+(2*length/3)
  end

  def x3
    x0+length
  end

  def y0
    0
  end

  def y1
    y0+(length/3)
  end

  def y2
    y0+(2*length/3)
  end

  def y3
    y0+length
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
