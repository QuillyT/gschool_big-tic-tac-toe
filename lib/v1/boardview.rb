class BoardView

  attr_reader :game, :process

  def initialize(game)
    @game = game
    @process = game.big_game
    setup_board
  end

  def length
    game.length - 2*shift
  end

  def shift
    game.length/10
  end

  def setup_board
    draw_lines
  end

  def winner(turn)
    process.stroke_weight 10
    if turn == game.player1
      process.stroke(115,0,0)
      process.line(x0,y3,x3,y0)
      process.line(x0,y0,x3,y3)
    else
      process.stroke(0,115,0)
      process.no_fill()
      process.arc((x0+x3)/2,(y0+y3)/2,length,length,0,2*Math::PI)
    end
    process.stroke_weight 5
  end

  def draw_lines
    process.stroke(0,0,100)
    process.line(x1, y0, x1, y3)
    process.line(x2, y0, x2, y3)
    process.line(x0, y1, x3, y1)
    process.line(x0, y2, x3, y2)
  end

  def x0
    game.starting_positions[game.game_number][0]+shift
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
    game.starting_positions[game.game_number][1]+shift
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

  def draw_x(position)
    if position.nil?
      return
    end
    process.stroke(140,0,0)
    process.line(position[0]-foo, position[1]-foo, position[0]+foo, position[1]+foo)
    process.line(position[0]+foo, position[1]-foo, position[0]-foo,position[1]+foo)
  end

  def foo
    length/6-length/10
  end

  def bar
    length/3-2*length/10
  end



  def draw_o(position)
    if position.nil?
      return
    end
    process.stroke(0,140,0)
    process.noFill()
    process.arc(position[0],position[1],bar,bar,0,2*Math::PI)
  end

end
