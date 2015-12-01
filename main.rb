require_relative 'pawns'
require 'gosu'
class Main
	def initialize
		@background_image = Gosu::Image.new("Board.jpg")
	end
end