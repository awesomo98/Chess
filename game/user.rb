require 'gosu'
require_relative 'game'

class User < Gosu::Window
	attr_reader :game
	def initialize
		super(720, 720, false)
		self.caption = "Chess Wizard Master"

		@background_image = Gos
	end
end