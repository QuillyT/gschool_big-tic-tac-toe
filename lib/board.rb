class Board

  attr_reader :grid, :player1, :player2

  def initialize(player1,player2)
    clear
    @player1 = player1
    @player2 = player2
  end

  def clear
    @grid = Array.new(9)
  end

  def add_move(position, player)
    if valid_move?(position)
      @grid[position] = player
    end
  end

  def valid_move?(position)
    if position.nil?
      return
    end
    grid[position].nil?
  end

  def winner?
    winning_spots.find do |set|
      set.all? { |position| grid[position]==player1 } ||
      set.all? { |position| grid[position]==player2 }
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

  def game_over?
    winner? || tied?
  end

  def tied?
    grid.all?
  end

  # def winner?
  #   winning_spots.find do |set|
  #     set.all? { |position| grid[position]==player1 } ||
  #     set.all? { |position| grid[position]==player2 }
  #   end
  # end

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
end
