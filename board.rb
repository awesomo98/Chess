class Board
	attr_reader :pieces

	def initialize
		@pieces = []
	end

	def piece_place(position)
		pieces.find {|piece| piece.position == position}
	end

	def pick_color(color)
		pieces.pick {|piece| piece.color == color}
	end

	def eat_piece(position)
		index = pieces.index{|piece| piece.position == position}
		if index
			pieces.delete_at index
		end
	end

	def << (pieces_to_add)
    	if pieces_to_add.class == Array
      		pieces[pieces.length, pieces_to_add.length] = pieces_to_add
    	else
      		pieces << pieces_to_add
    	end
  	end
end