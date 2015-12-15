module Calculations # call it moves?
	def position_change(position_1, position_2)
		position_1.chars.zip(position_2.chars).collect do |pair|
			pair.collect(&:ord).reduce(:-) 
		end
	end

	def squares_between(position_1, position_2)
		squares_between_row(position_1, position_2) ||
		squares_between_diagonal(position_1, position_2)
	end

	def squares_between_row(position_1, position_2)
		row = position_1 =~ Regexp.new("[#{position_2}]")
		return if row.nil?
		range = difference(position_1[1 - row], position_2[1 - row])
		squares = range.collect {|column| "#{column}#{position_1[row]}"}
		squares.collect!(&:reverse) if row == 0
		squares[1..-2]
	end

	def difference(a, b)
		if a > b
			(b..a)
		else
			(a..b)
		end
	end

	def squares_between_diagonal(position_1, position_2)
		direction = diagonal(position_1, position_2)
		return if direction.nil?
		squares = []
		square = "#{position_1}"
		until squares[-1] == position_2
			square[0] = (square[0].ord + direction[0]).chr
			square[1] = (square[1].ord + direction[1]).chr
			squares << "#{square}"
		end
		squares[0..-2]
	end

	def diagonal(position_1, position_2)
		direction = position_difference(position_1, position_2)
		return nil unless direction.collect(&:abs).reduce(:==)
		direction.collect {|num| - (num / num.abs)}
	end

	def board_spaces
		("A1".."H8").to_a.reject { |square| square =~ /\w[09]/ }
	end

	def pawn_spaces(position, position_final)
		spaces = position_difference(position, position_final)[1]
		spaces *= -1 if color == :white
		spaces
	end

	def other_color(player_color)
		player_color == (
			if :white
				:black
			else
				:white
			end)
	end
end