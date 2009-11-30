#!/usr/bin/env ruby

require 'src/zorder'
require 'src/trajectory'
require 'src/Geometry/circle'

# This class represents a catchable bonus.
class Bonus
  
  attr_reader :x, :y, :vx, :vy, :width, :height
  
  @@image = nil
  
  def initialize(window, player, x, y, trajectory)
    @window, @player = window, player
    @x, @y = x, y
    @trajectory = trajectory
    
    # Velocities
    @vx, @vy = 0, 0
    
    # Dimensions
    @width, @height = 20, 20
  end
  
  # Velocities are modified by this method via
  # the call to <b>@trajectory</b> method.
  def apply_traj
    @vx, @vy = @trajectory.call(self)
  end
  
  # Standard update method
  def update
    apply_traj
    @x += @vx
    @y += @vy
    
    # Returns false to be removed if out of frame or catched by player
    to_be_kept?
  end
  
  # Is this object supposed to be kept in game?
  def to_be_kept?
    inside_frame? and !catched?(@player)
  end
  
  # Standard <b>draw()</b> method.
  def draw
    @@image.draw(@x - @@image.width / 2, @y - @@image.height / 2, ZOrder::Player)
  end
  
  # Indicates if this bonus is still in the game frame.
  def inside_frame?
    @y < FRAME_HEIGHT + @height && @y > -@height && @x < FRAME_WIDTH + @width && @x > -@width
  end
  
  # Return circular collision mask.
  def getCollisionMask
    Circle.new(@x, @y, [@width, @height].max/2.0)
  end
  
  # Does this ennemy touch player?
  def catched?(player)
    if player.is_alive? and getCollisionMask.intersects_with?(player.getCollisionMask) 
      give_bonus(player)
      true
    else
      false
    end
  end
  
  # To override according to <code>@content</code>
  def give_bonus player
  end
  
end
