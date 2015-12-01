require_relative 'pawns'
require 'gosu'
class Main
	def initialize
		self.caption "Chess Wizard Master"

		@background_image = Gosu::Image.new("Board.jpg")
	end

	def button_down(id)
		close if id == Gosu::Kb
	end
end