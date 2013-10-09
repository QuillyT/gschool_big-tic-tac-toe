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

  def top_left

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

  # def mouse_pressed(mouse_x, mouse_y)
  # 	game.process_click(mouse_x, mouse_y)
  # end

  # def update_view
  # 	game.board.grid.each_index do |index|
  # 		if @game.board.grid[index] == @game.player1
  # 			draw_x(game.coordinate_hash.invert[index])
  #     end
  # 		if @game.board.grid[index] == @game.player2
  # 			draw_o(game.coordinate_hash.invert[index])
  # 		end
  # 	end
  # end

  def draw_x(position)
    game.fill(0,0,0)
    game.line(position[0]-90, position[1]-90, position[0]+90,position[1]+90)
    game.line(position[0]+90, position[1]-90, position[0]-90,position[1]+90)
  end

  # def draw_o(position)
  #   game.fill(0,0,0)
  #   game.ellipse(position[0],position[1],180,180)
  #   game.fill(255,255,255)
  #   game.ellipse(position[0], position[1], 175, 175)
  # end

  # def winner(turn)
  #   game.background(255,255,255)
  #   if turn == game.player1
  #     winner_x
  #   else
  #     winner_o
  #   end
  # end

  # def winner_x
  #   game.fill(0,0,0)
  #   game.line(10,610,610,10)
  #   game.line(10,10,610,610)
  # end

  # def winner_o
  #   game.fill(0,0,0)
  #   game.ellipse(310,310,600,600)
  #   game.fill(255,255,255)
  #   game.ellipse(310,310,580,580)
  # end

  # def tied
  #   blank_screen
  #   winner_o
  #   winner_x
  # end

end