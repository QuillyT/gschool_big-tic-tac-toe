require 'pry'
class TicTacToe


	def initialize
		@board = ['_', '_', '_', '_', '_', '_', '_', '_', '_']
		@turn = 0
	end

	def run

		input = ""

		while input!='quit'

			if @turn == 0
				puts "Player 1 Enter Move: "
			else
				puts "Player 2 Enter Move: "
			end

			input = gets.chomp

			if valid_move?(input)
				spot = input.to_i
				play_move(spot, @turn)
				check_win
				print_board
				@turn = (@turn + 1) % 2
			else
				puts "Invalid Move"
			end

		end
	end

	def check_win
		
	end

	def play_move(move, player)
		@board[move] = player
	end

	def valid_move?(entry)
		entry.scan(/\d/).size == 1
	end

	def print_board
		@board.each_index do |index| 
			print @board[index] 
			# binding.pry
			if (index+1) % 3 == 0
				puts ""
			end
		end
	end

end

t = TicTacToe.new
t.run