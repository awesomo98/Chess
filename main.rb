require_relative 'pawns'
require 'gosu'
class Window < Gosu::Window
	def initialize
		self.caption "Chess Wizard Master"

		@background_image = Gosu::Image.new("Board.jpg")
	end

	def button_down(id)
		close if id == Gosu::Kb
	end
end

window = Window.new
window.show