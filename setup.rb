require_relative 'piece'
require_relative 'board'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/king'
require_relative 'pieces/pawns'

class Setup
	def create
		make_pieces(Board.new)
	end

	def make_pieces(board)
		back_row(board, :black, 8)
		back_row(board, :white, 1)
		pawns(board, :black, 7)
		pawns(board, :white, 2)
		board
	end

	def back_row(board, color, rank)
		order = ("A".."H").to_a.zip(
			[:Rook, :Knight, :Bishop, :Queen, :King, :Bishop, :Knight, :Rook])
		board << order.collect do |pair|
			Kernel.const_get(pair[1]).new(color, "#{pair[0]}#{rank}")
		end
	end

	def pawns(board, color, rank)
		board << ("A".."H").collect do |file|
			Pawns.new(color, "#{file}#{rank}")
		end
	end
end