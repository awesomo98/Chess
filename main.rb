require_relative 'z_order'
# require_relative 'game'
require 'gosu'


class Window < Gosu::Window
	attr_reader :game
	def initialize
		super 363, 335
		self.caption = "Chess Wizard Master"
		# @game = Game.new
		@background_image = Gosu::Image.new("images/Board.jpg")
		# create_images
	end

	def needs_cursor?
		true
	end

	def button_down(id)
		return unless id == Gosu::MsLeft
		if game.waiting_for_input?
			select_input_piece
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
		@selected_piece = nil if @selected_piece.instance_of? NullPiece
		@moves = game.get_legal_moves(@selected_piece) if @selected_piece
	end

	def update
		
	end

	def draw
		@background_image.draw(0, 0, ZOrder::BACKGROUND)
		draw_pieces
		draw_possible moves
		draw_selected_piece
		draw_input_pieces(game.turn.to_s.split("_")[0].to_sym) if game.waiting_for_input
	end

	def rectangle(x, y, width, height)
		draw_quad(x, y, @background, x, height + y, @background, width + x, y, @background, width + x, height + y, @background)
	end

	def draw_selected_piece
		if @selected_piece
			find_piece_image(@selected_piece.file.loc).draw(self.mouse_x - 45, mouse_y - 45, 0)
		end
	end

	def draw_possible_moves
		return unless @selected_piece
		@moves.each do |move|
		
	end
end

window = Window.new
window.show