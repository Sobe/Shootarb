#!/usr/bin/env ruby

require 'src/config'
require 'src/Ennemies/ennemy'

include Config

# Dumb simple ennemy.
class Dummy_Ennemy < Ennemy
     
  def initialize(window, x, y)
    super(window, x, y)
    
    # Dimensions
    @width, @height = 50, 50
    # Score value
    @score_pts = 10
    
    # Horizontal/vertical velocity.
    @vx = 0 
    @vy = 3
    
    @image = Gosu::Image.new(@window, "media/DarkEnnemy.bmp", false)
  end
  
end