require "gosu"
require_relative "player"

class Cakehold
	def initialize animation
		@animation = animation
		@score = 0
		@x = 300
		@y = 500
		@anim = 0
	end

	def draw layer
		img = @animation[layer]
		img.draw(@x, @y, 2)
	end

end