class Checker
	include Calculations

	attr_accessor :last_move, :board

	def initialize(board)
		@board = board
		pick_kings
	end

	def valid_move?(piece, position_going)
		return false if piece.position == position_going
		other_piece = board.piece_at(position_going) || NullPiece.new
		return false if same_color?(piece, other_piece)
		return false unless if other_piece.class == NullPiece
			piece.can_move?(position_going)
		else
			piece.can_eat?(position_going)
		end
		return false if still_in_check?(piece, position_going) || piece_in_way?(piece, position_going)
		true
	end

	def still_in_check?(piece, position_going)
		temp_position = piece.position
		piece.position = position_going
		check = in_check?(piece.color, position_going)
		piece.position = temp_position
		check
	end

	def in_check?(color, no_position = "")
		board.select_color(other_color(color)).any? do |piece|
			unless no_position == piece.position || piece_in_way?(piece, @kings[color].position)
				piece.can_eat?(@kings[color].location)
			end
		end
	end

	def piece_in_way?(piece, position_going)
		return false unless [Rook, Bishop, Queen, Pawn].include?(piece.class)
		spaces = spaces_between(piece.position, position_going)
		return unless spaces
		spaces.any? {|space| board.piece_at(space) }
	end

	def same_color?(piece, other_piece)
		piece.color == other_piece.color
	end

	def pick_pieces(*spaces)
		spaces.collect {|space| board.piece_at(space)}
	end

	def pick_kings
		@kings = {white: board.piece_at("E1"), black: board.piece_at("E8")}
	end


end