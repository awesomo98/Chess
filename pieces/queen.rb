class Queen < Piece
	include Calculations

	def initialize(color, position)
		super(color, position)
	end

	def can_move?(position_final)
		position_change(position, position_final).all?
	end

	def can_eat?(enemy_position)
		can_move(enemy_position)
	end


end