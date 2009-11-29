#!/usr/bin/env ruby

require 'src/config'
require 'src/particle'

include Config

# Abstract class for an ennemy.
class Ennemy
  attr_reader :x, :y, :vx, :vy, :score_pts, :width, :height
  
  def initialize(window, x, y)
    # Parent window and position
    @window, @x, @y = window, x, y
    
    
    # Dimensions
    @width, @height = 0, 0
    
    # Score value
    @score_pts = 0

    # Velocities
    @vx, @vy = 0, 0
    
  end
  
  # Standard update() method.
  def update
    @x += @vx
    @y += @vy
    
    # Returns false to be removed if out of frame or crashed on player
    inside_game_area? and !touch?(@window.player)
  end
  
  # Standard <b>draw()</b> method.
  def draw
    @image.draw(@x - @image.width / 2, @y - @image.height / 2, ZOrder::Player)
  end
  
  # Indicates if this ennemy is still in the game area.
  # Warning: "game area" does not mean "window area".
  def inside_game_area?
    @y < FRAME_HEIGHT + 3*@height && @y > -3*@height && @x < FRAME_WIDTH + 3*@width && @x > -3*@width
  end
  
  # Return circular collision mask.
  def getCollisionMask
    Circle.new(@x, @y, [@width, @height].max/2.0)
  end
  
  # Does this ennemy touch player?
  def touch?(player)
    if player.is_alive? and getCollisionMask.intersects_with?(player.getCollisionMask) 
      player.touched
      crash
      true
    else
      false
    end
  end
  
  def crash
    [@width, @height].max.times do
      p_vx = rand(100)/10.0 - 5
      p_vy = rand(100)/10.0 - 5
      @window.particles << Particle.new(@window, @x + rand(@width) - @width/2, @y + rand(@height) - @height/2, p_vx, p_vy)
    end
  end
  
end