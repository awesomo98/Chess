require_relative 'pawns'
require_relative 'z_order'
require 'gosu'


class Window < Gosu::Window
	def initialize
		super 363, 335
		self.caption = "Chess Wizard Master"

		@background_image = Gosu::Image.new("Board.jpg")
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

	def draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
	end
end

window = Window.new
window.show