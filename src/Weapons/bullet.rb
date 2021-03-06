#!/usr/bin/env ruby

require 'src/config'
require 'src/Geometry/circle'

include Config

# Player's bullet.
class Bullet
  attr_reader :x, :y, :vx, :vy, :width, :height, :damage
  
  def initialize(window, player, x, y, vx=0, vy=7)
    @window, @x, @y = window, x + vx, y + vy
    @player = player
    
    # Horizontal/vertical velocity.
    @vx = vx
    @vy = -vy
    
    # Dimensions
    @width, @height = 10, 10
    
    # Strenght
    @damage = 10
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
    @window.draw_quad(x-@width/2, y-@height/2, 0xffff0000, x+@width/2, y-@height/2, 0xffff0000, 
      x-@width/2, y+@height/2, 0xffff0000, x+@width/2, y+@height/2, 0xffff0000, 0)
  end
  
  # Does this bullet touch a guy in 'ennemies'?
  def touch?(ennemies)
    touched = false
    ennemies.each do |e|
      if e.getCollisionMask.intersects_with?(getCollisionMask)
        e.touched_by self
        touched = true
      end
    end
    touched
  end
  
  def located_in_frame?
      @y < FRAME_HEIGHT + @height && @y > -@height && @x < FRAME_WIDTH + @width && @x > -@width
  end
  
  # Return circular collision mask.
  def getCollisionMask
    Circle.new(@x, @y, [@width, @height].max/2.0)
  end
  
end