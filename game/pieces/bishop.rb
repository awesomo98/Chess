require_relative 'calculations'

class Bishop < Piece
	include Calculations


	def initialize(color, position)
		super(color, position)
	end

	def can_move?(position_final)
		diagonal(position, position_final)
	end

	def can_eat?(position_enemy)
		can_move?(position_enemy)
	end
end