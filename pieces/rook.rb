require_relative 'calculations'

class Rook < Piece
	include Calculations

	def initialize(color, position)
		super(color, position)
	end

	def can_move?(position_final)
		position =~ Regexp.new("[#{position_final}]")
	end

	def can_eat?(enemy_position)
		can_move(enemy_position)
	end
end