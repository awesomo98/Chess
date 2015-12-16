class Piece
	attr_reader :color
	attr_accessor :position
	
	def initialize(color, position = "A1")
		@color = color
		@position = position
	end

	def file
		type = self.class.to_s == self.class.to_s[0].downcase
		color[0] + type
	end

	def move
		@moved = true
	end

	def moved?
		@moved
	end

	def to_array
		Piece.position_to_array(position)
	end

	def self.position_to_array(position)
		row = 8 - position[1].to_i
		column = position[0].ord - 65
		[row, column]
	end
end