class Pawn < Piece
	include	Calculations

	def initialize(color, position)
		super(color, position)
	end

	def can_move?(position_final)
		spaces = spaces_sideways(position_final)
		can_move_forward?(position_final) && spaces == 0
	end

	def can_move_forward?(position_final)
    return false unless spaces_sideways(position_final) == 0
    spaces = spaces_moving_pawn(position, position_final)
    spaces == 1 || (!moved? && spaces == 2)
  end

  def can_eat?(position_final)
    spaces_moving_pawn(position, position_final) == 1 &&
    spaces_sideways(position_final) == 1
  end

  def spaces_sideways(position_final)
    (position[0].ord - position_final[0].ord).abs
  end
end