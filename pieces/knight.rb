class Knight < Piece
	include Calculations

	def initialize(color, position)
		super(color, position)
	end

	def can_move?(position_final)
		jump(position, position_final)
	end

	def can_eat?(enemy_position)
		can_move(enemy_position)
	end
end