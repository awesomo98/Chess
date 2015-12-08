module Calculations # call it moves?
	def position_change(position_1, position_2)
		position_1.chars,zip(position_2.chars).collect do |pair|
			pair.collect(&:ord).reduce(:-) 
		end
	end

	def squares
		
	end
end