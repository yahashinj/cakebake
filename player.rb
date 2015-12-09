require "gosu"

class Player

	attr_reader :score, :x, :y 
	
	def initialize animation
		@animation = animation
		@score = 0
		@x = 300
		@y = 500
		@anim = 0
		@angle = 90
		@layer = 1
	end

	def draw
		img = @animation[0]
		img.draw(@x, @y, 1)
	end

	def draw_anim
		img = @animation[@anim / 5 % @animation.size]
		img.draw(@x, @y, 1)
	end

	def move_left
		@x -= 5
		@anim += 1

		@x = 790 if @x <= -100
	end

	def move_right
		@x += 5
		@anim += 1
		@x = -90 if @x >= 810
	end

	def warp(x, y)
		@x, @y = x, y
	end

	def catch cake
		if cake.reject! {|cake| Gosu::distance(@x, @y, cake.x, cake.y) < 20 && @layer !=cake.layer} then
			@layer = 1
		end

		if cake.reject! {|cake| Gosu::distance(@x, @y, cake.x, cake.y) < 20 && @layer == cake.layer} then
			@layer += 1
		end
		print @layer
	end

end