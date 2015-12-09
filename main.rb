require "gosu"
require_relative "player"
require_relative "cake"
require_relative "cakehold"

class Main < Gosu::Window
	
	def initialize
		super 800, 800
		self.caption = "Cake Baking Simulator 2015"
		@background = Gosu::Image.new("media/background.png")
		@player_anim = Gosu::Image::load_tiles("media/chef.png", 114, 216)
		@cake_hold_anim = Gosu::Image::load_tiles("media/cake_hold.png", 200, 200)
		@cake_layers = []
		(1..5).each do |n|
			@cake_layers[n] = Gosu::Image.new("media/cake#{n.to_s}.png")
		end
		@player = Player.new(@player_anim)
		@cake = Array.new
		@cake_hold = Cakehold.new(@cake_hold_anim)
	end

	def update
		@player.move_left if Gosu::button_down? Gosu::KbLeft
		@player.move_right if Gosu::button_down? Gosu::KbRight

		if rand(100) < 2 && @cake.size < 5
			@cake.push(Cake.new(@cake_layers))
		end

		@cake.each { |cake| cake.fall }

		@player.catch(@cake)

		remove_offscreen(@cake)
	end

	def button_down(id)
		close if id == Gosu::KbEscape
	end

	def draw
		@background.draw(0, 0, 0)
		@player.draw_anim
		@cake.each { |cake| cake.draw }
		# @cake_hold.draw(@player.layer)
	end

	def remove_offscreen objects
			objects.reject! { |object| object.y > height}
		end

end

window = Main.new 
window.show