class Knight < Piece
	include Calculations

	def initialize(color, position)
		super(color, position)
	end

	def can_move?(position_final)
		differences = position_difference(position, position_final).collect(&:abs)
		differences == [2, 1] || differences == [1, 2]
	end

	def can_eat?(enemy_position)
		can_move(enemy_position)
	end
end