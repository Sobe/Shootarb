#!/usr/bin/env ruby

require 'src/particle'

# This class represent a 1 pixel particle with limited life span.
class Live_Particle < Particle
  
  def initialize(window, x, y, vx, vy, color, max_age)
    @window = window
    @x, @y, @vx, @vy = x, y, vx, vy
    @color = color
    super(window, x, y, vx, vy, color)
    @max_age = max_age
    @birth_t = Time.now
  end
  
  # Standard update method.
  def update
    @x = @x + @vx
    @y = @y + @vy
    
    located_in_frame? and Time.now - @birth_t < @max_age
  end
  
end