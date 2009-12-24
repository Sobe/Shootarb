#!/usr/bin/env ruby

require 'src/config'

include Config

# Bullet shot by an Ennemy.
class Ennemy_Bullet
  
  attr_reader :x, :y, :vx, :vy, :width, :height
  
  def initialize(window, player, x, y, vx=0, vy=4)    
    # Horizontal/vertical velocity.
    @vx = vx
    @vy = vy
    
    @window, @x, @y = window, x + @vx, y + @vy
    @player = player
    
    @width, @height = 10, 10
  end
  
  def update
    # Movement, gravity
    @x += @vx
    @y += @vy
   
    # Returns false to be removed if out of frame
    located_in_frame?
  end
  
  def draw
    # Just draw a small quad.
    @window.draw_quad(x-5, y-5, 0xffff0000, x+5, y-5, 0xffff0000, 
      x-5, y+5, 0xffff0000, x+5, y+5, 0xffff0000, 0)
  end
  
  # Does this bullet touch the player?
  def touch?(player=@player)
    if (player.getCollisionMask.intersects_with?(getCollisionMask)) and player.status == :alive
      player.touched
      true
    else
      false
    end
  end
  
  def located_in_frame?
    @y < FRAME_HEIGHT + 10 && @y > -10 && @x < FRAME_WIDTH + 10 && @x > -10
  end
  
  # Return circular collision mask.
  def getCollisionMask
    Circle.new(@x, @y, [@width, @height].max/2.0)
  end
    
end