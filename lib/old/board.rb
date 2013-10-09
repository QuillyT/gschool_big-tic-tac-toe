class Board

  attr_reader :grid

  def initialize
    clear
  end

  def clear
    @grid = Array.new(9)
  end

  def execute_move(position, player)
    if valid_move?(position)
      grid[position] = player
      true
    else
      false
    end
  end

  def valid_move?(position)
    grid[position].nil?
  end

end
