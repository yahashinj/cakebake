require "gosu"
require_relative "player"

class Main < Gosu::Window
	
	def initialize
		super 800, 800
		self.caption = "Cake Baking Simulator 2015"
		@background = Gosu::Image.new("media/background.png")
		@player_anim = Gosu::Image::load_tiles("media/chef.png", 114, 216)
		@player = Player.new(@player_anim)
	end

	def draw
		@background.draw(0, 0, 0)
		@player.draw_anim
	end

	def update
		@player.move_left if Gosu::button_down? Gosu::KbLeft
		@player.move_right if Gosu::button_down? Gosu::KbRight
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

end

window = Main.new 
window.show