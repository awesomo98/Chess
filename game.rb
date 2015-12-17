require_relative 'setup'
require_relative 'check_moves'
require_relative 'pieces/calculations'

class Game
	include Calculations

	attr_reader :board, :turn, :checker

	def initialize(generator = Setup.new)
		@generator = generator
		restart
	end

	def move(initial_position, final_position)
		return unless your_move?(initial_position, final_position)
		return if initial_position == final_position
		return puts "invalid move" unless checker.valid_move?(get_piece(initial_position), final_position)

		use_piece(get_piece(initial_position), final_position)
		switch_turns
		checker.last_move = [initial_position, final_position]
		upgrade_pawn
	end

	def use_piece(piece, position)
		eat_piece(piece, position)
		move_piece(piece, position)
	end

	def eat_piece(piece, final_position)
		board.eat_piece(final_position)
	end

	def move_piece(piece, location)
		piece.move
		piece.position = position
	end

	def your_move?(initial_position, final_position)
		turn == get_piece(initial_position).color
	end

	def upgrade_pawn(upgrade_piece)
		return unless waiting_for_upgrade?
		@turn = turn.to_s.split("_")[0].to_sym
		board.eat_piece(checker.last_move[1])
		board << upgrade_piece.new(turn, checker.last_move[1])
		switch_turns
	end

	def queue_upgrade_pawn
	pawn = get_piece(checker.last_move[1])
    return unless pawn.class == Pawn && ["8", "1"].include?(pawn.position[1])
    @turn = "#{other_color(turn)}_promotion".to_sym
	end

	def waiting_for_upgrade?
		turn.to_s.include?("_upgrade")
	end

	def valid_moves(piece)
		board_spaces.select {|square| checker.valid_move?(piece, square)}
	end

	def checkmate?(color)
		board.select_color(color).all? {|piece| valid_moves(piece).empty?}
	end

	def switch_turns
		@turn = other_color(turn)
	end

	def get_piece(position)
		board.piece_place(position) || NullPiece.new
	end

	def restart
		@board = @generator.create
		@checker = CheckMoves.new(board)
		@turn = :white
	end

	class NullPiece
		def color
			:none
		end

		def position
			"Z0"
		end
	end
end