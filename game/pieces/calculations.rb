module Calculations # call it moves?
	def position_change(position_1, position_2)
		position_1.chars,zip(position_2.chars).collect do |pair|
			pair.collect(&:ord).reduce(:-) 
		end
	end

	def squares_between(position_1, position_2)
		squares_between_row(position_1, position_2) ||
		squares_between_diagonal(position_1, position_2)
	end

	def squares_between_row(position_1, position_2)
		row = location_one =~
	end
end