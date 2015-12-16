require_relative 'z_order'
require_relative 'board'
require_relative 'game'
# require_relative 'piece'
require 'gosu'


class Window < Gosu::Window
	attr_reader :game
	def initialize
		super 720, 720
		self.caption = "Chess Wizard Master"
		@game = Game.new
		@background_image = Gosu::Image.new("images/Board.png")
		create_pieces
		@font = Gosu::Font.new(20)
	end

	def needs_cursor?
		true
	end

	def button_down(id)
		return unless id == Gosu::MsLeft
		if game.waiting_for_upgrade?
			select_upgrade_piece
		elsif @selected_piece
			make_move
		else
			pick_up_piece
		end
	end

	def make_move
		game.move(@selected_piece.position, mouse_position)
		@selected_piece = nil
	end

	def pick_up_piece
		@selected_piece = game.get_piece(mouse_position)
		# @selected_piece = nil if @selected_piece.instance_of? NullPiece
		@moves = game.valid_moves(@selected_piece) if @selected_piece
	end

	def draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		draw_pieces
		draw_possible_moves
		draw_selected_piece
		draw_upgrade_pieces(game.turn.to_s.split("_")[0].to_sym) if game.waiting_for_upgrade?
		# @font.draw("Turn: ")
	end

	def rectangle(x, y, width, height)
		draw_quad(x, y, @background, x, height + y, @background, width + x, y, @background, width + x, height + y, @background)
	end

	def draw_selected_piece
		if @selected_piece
			find_piece_image(@selected_piece.file.pos).draw(self.mouse_x - 45, mouse_y - 45, 0)
		end
	end

	def draw_possible_moves
		return unless @selected_piece
		@moves.each do |move|
			y, x = Piece.position_to_array_indexes(move).collect { |index| index * 90 }
			if game.board.piece_at(move)
				transparency = 0x88ffffff
			else
				transparency = 0x33ffffff
			end
			find_piece_image(@selected_piece.file_pos).draw(x, y, 0, 1, transparency)
		end
	end

	def draw_pieces(pieces = game.board.pieces.reject { |piece| piece == @selected_piece} )
		pieces.each do |piece|
			y, x = piece.to_array.collect { |index| index * 90 }
			unless @selected_piece && @moves.include?(piece.position)
				find_piece_image(piece.file).draw(x, y, ZOrder::PIECES)
			else
				find_piece_image(piece.file).draw(x, y, 0, 1, 1, 0x33ffffff)
			end
		end
	end

	def create_pieces
		@piece_images = piece_image.collect { |path| Gosu::Image.new(self, "images/#{path}.png", true) }
	end

	def mouse_position(start_x = 0, start_y = 0)
		x = 8 - ((self.mouse_y - start_x) / 90).to_i
		y = ((self.mouse_x - start_y) / 90).to_i + 65
		"#{y.chr}#{x}"	
	end

	def find_piece_image(file)
		@piece_images[piece_image.index(file)]
	end

	def piece_image
		%w(bb bk bn bp bq br wb wk wn wp wq wr)
	end

	def select_upgrade_piece
		pos = mouse_position(*upgrade_pieces_start_position)
		return unless pos[1] == "8"
		pieces = [Queen, Rook, Bishop, Knight]
		type = pieces[pos[0].ord - 65]
		game.upgrade_pawn(type) if type
	end

	def draw_upgrade_pieces(color)
		y, x = upgrade_pieces_start_position
		rectangle(x, y, 360, 90)
	end


end

window = Window.new
window.show