class Pieces
	def initialize
		@x = @y
		@image = Gosu::Image.new("images/#{color}/#{piece}")
	end

	def file
		type = self.class.to_s == "Knight" ? "n" : self.class.to_s[0].downcase
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