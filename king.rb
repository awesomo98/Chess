class King
	def initialize
		@x = @y
		@white_image = Gosu::Image.new("pieces/white/king.png")
		@black_image = Gosu::Image.new("pieces/black/king.png")
	end

	def draw
		piece = king
		draw.pieces
	end
end