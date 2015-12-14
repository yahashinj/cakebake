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
		@cake_hold_anim = Gosu::Image::load_tiles("media/cake_hold.png", 100, 100)
		@cake_layers = []
		(1..5).each do |n|
			@cake_layers[n] = Gosu::Image.new("media/cake#{n.to_s}.png")
		end
		@player = Player.new(@player_anim)
		@cake = Array.new
		@cake_hold = Cakehold.new(@cake_hold_anim)
		@font = Gosu::Font.new(20)
		@time = 20
	end

	def update
		return if game_over?

		@player.move_left if Gosu::button_down? Gosu::KbLeft
		@player.move_right if Gosu::button_down? Gosu::KbRight

		if Gosu::milliseconds % 40 == 0 && @cake.size < 15
			@cake.push(Cake.new(@cake_layers))
		end

		@cake.each { |cake| cake.fall }

		@player.catch(@cake)

		remove_offscreen(@cake)

		@player.score?

		@time = 2 - (Gosu::milliseconds / 1000)


	end

	def button_down(id)
		close if id == Gosu::KbEscape
		restart if id == Gosu::KbSpace && game_over?
	end

	def game_over?
		true if @time < 0
	end	

	def draw
		game_play_screen
		game_over_screen if game_over?
		@player.draw_anim
		@cake.each { |cake| cake.draw }
		@cake_hold.draw(@player.x, @player.y, @player.layer)
	end

	def remove_offscreen objects
		objects.reject! { |object| object.y > height}
	end

	def game_over_screen
		Gosu::draw_rect(0, 0, width, height, 0xff_000000, 4)
		@font.draw("Score: #{@player.score}", 370, height/3 + 150, 4, 1.0, 1.0, 0xff_ffffff)
		@font.draw("GAME OVER", 300, height/3, 4, 2.0, 2.0, 0xff_ffffff)
	end

	def game_play_screen
			@background.draw(0, 0, 0)
			@font.draw("Score: #{@player.score}", 10, 10, 4, 1.0, 1.0, 0xff_0000bb)
			@font.draw("Time: #{@time}", 500, 10, 4, 1.0, 1.0, 0xff_0000bb)
		end		

	def restart
		@background = Gosu::Image.new("media/background.png")
		@player_anim = Gosu::Image::load_tiles("media/chef.png", 114, 216)
		@cake_hold_anim = Gosu::Image::load_tiles("media/cake_hold.png", 100, 100)
		@cake_layers = []
		(1..5).each do |n|
			@cake_layers[n] = Gosu::Image.new("media/cake#{n.to_s}.png")
		end
		@player = Player.new(@player_anim)
		@cake = Array.new
		@cake_hold = Cakehold.new(@cake_hold_anim)
		@font = Gosu::Font.new(20)
		@time = 20

		print "TEST"
	end

end

window = Main.new 
window.show