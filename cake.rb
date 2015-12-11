require "gosu"

class Cake

	attr_reader :x, :y, :layer
	
	def initialize cake_layers
		@cake_layers = cake_layers
		@x = rand * 750
		@y = -100
		@layer = (rand * 5 + 1).to_i
	end

	def draw
		@cake_layers[@layer].draw(@x, @y, 1)
	end

	def fall
		@y += 3
	end




end