require "gosu"
require_relative "player"

class Cakehold
	def initialize (animation)
		@animation = animation
		@x = 300
		@y = 500
		@anim = 0
	end

	def draw (x, y, layer)
		img = @animation[layer - 1]
		img.draw(x, y + 50, 2)
	end

end