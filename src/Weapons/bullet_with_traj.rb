#!/usr/bin/env ruby

require 'src/Weapons/bullet'

# Player's bullet using Trajectory.
class Bullet_With_Traj < Bullet
  
  def initialize(window, player, x, y, traj)
    @window, @x, @y = window, x, y
    @player = player
    
    # Horizontal/vertical velocity.
    @vx = 0
    @vy = 0
    
    # Dimensions
    @width, @height = 10, 10
    
    # Damages
    @damage = 10
    
    # Traj
    @trajectory = traj
    @creation_t = Time.now
  end
  
  # Velocities are modified by this method via
  # the call to <b>@trajectory</b> method.
  def apply_traj
    @vx, @vy = @trajectory.call(self)
    # Trajectories are often with vy > 0
    @vy *= -1
  end
  
  def update
    apply_traj
    super
  end
  
end
