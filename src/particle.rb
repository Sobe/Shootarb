#!/usr/bin/env ruby

require 'src/config'

include Config

# This class represent a 1 pixel particle.
class Particle
  
  def initialize(window, x, y, vx, vy, color=0xffff0000)
    @window = window
    @x, @y, @vx, @vy = x, y, vx, vy
    @color = color
  end
  
  # Standard update method.
  def update
    @x = @x + @vx
    @y = @y + @vy
    
    located_in_frame?
  end
  
  def draw
    @window.draw_quad(@x-1, @y-1, @color, @x+1, @y-1, @color, @x-1, @y+1, @color, @x+1, @y+1, @color, 0)
  end
  
  def located_in_frame?
    @y < FRAME_HEIGHT && @y > -10 && @x < FRAME_WIDTH && @x > -10
  end
  
end
