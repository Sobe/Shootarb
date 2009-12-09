#!/usr/bin/env ruby

require 'src/config'
require 'src/live_particle'
require 'src/Ruby_Extension/array'

include Config

# Abstract class for an ennemy.
class Ennemy
  attr_reader :x, :y, :vx, :vy, :score_pts, :width, :height, :window, :hp
  
  def initialize(window, x, y)
    # Parent window and position
    @window, @x, @y = window, x, y
    
    # Dimensions
    @width, @height = 0, 0
    
    # Score value
    @score_pts = 0

    # Velocities
    @vx, @vy = 0, 0
    
    # Health
    @hp = 10
    @to_be_removed = false
    
    # Colors
    @colors = [0xffdd0000, 0xff780000, 0xffbc7373]
    
  end
  
  # Standard update() method.
  def update
    @x += @vx
    @y += @vy
    
    # Returns false to be removed if out of frame or crashed on player
    touch?(@window.player)
    inside_game_area? and !@to_be_removed
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
    end
  end
  
  # When destroyed
  def crash
    [@width, @height].max.times do
      p_vx = rand(100)/10.0 - 5
      p_vy = rand(100)/10.0 - 5
      #@window.particles << Particle.new(@window, @x + rand(@width) - @width/2, @y + rand(@height) - @height/2, p_vx, p_vy)
      @window.particles << Live_Particle.new(@window, @x + rand(@width) - @width/2, @y + rand(@height) - @height/2, p_vx, p_vy, @colors.rand_in, 1 + rand)
    end
    @to_be_removed = true
  end
  
  # When touched by a bullet.
  def touched_by bullet
    damage bullet.damage
  end
  
  # Take damages
  def damage d
    @hp -= d
    if @hp <= 0
      crash
      @window.player.score += @score_pts
    end
  end
  
end