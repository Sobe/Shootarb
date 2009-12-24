#!/usr/bin/env ruby

# This module includes trajectories of a spatial object.
# It's basically functions that returns a 2D vector of velocities
# according to object <code>obj</code> internal state (position, current velocity,
# time of creation, etc.).
# They shall all respect this basic pattern:
# 
# <code>  traj: obj |--> [vx, vy]</code>
#
module Trajectory
  
  # Straight simply accelerating trajectory.
  def y_accel_traj(obj)
    [0, obj.vy + 0.1]
  end
  
  # Trajectory following player with a velocity of 1.
  def tracking_traj(obj)
    if obj.player.is_alive?
      vx = (obj.player.x - obj.x) / pts_distance([obj.player.x, obj.player.y], [obj.x, obj.y])
      vy = (obj.player.y - obj.y) / pts_distance([obj.player.x, obj.player.y], [obj.x, obj.y])
    else
      vx, vy = obj.vx, obj.vy
    end
    [vx, vy]
  end
  
  # Bouncing on the borders trajectory with a velocity of 2 on each axis.
  def bouncing_1_traj(obj)
    vx = (obj.x < obj.width/2.0)? 2 : ((obj.x > FRAME_WIDTH - obj.width/2.0)? -2 : obj.vx)
    vy = (obj.y < obj.height/2.0)? 2 : ((obj.y > FRAME_HEIGHT - obj.height/2.0)? -2 : obj.vy)
    [vx, vy]
  end
  
  # A bit randomized trajectory on X axis, constant 5 on Y axis.
  def few_random_traj(obj)
    [obj.vx + 2.0*rand - 1.0, 5]
  end
  
  # Dodging trajectory
  def dodge_traj(obj)
    vx = obj.vx
    # Dodge bullets
    obj.window.bullets.each do |b|
      if (obj.x - obj.width/2 - b.width/2 .. obj.x).include? b.x
        vx = 1
        # TODO break or something here
      elsif (obj.x .. obj.x + obj.width/2 + b.width/2).include? b.x
        vx = -1
        # TODO break or something here
      end
    end
    # Keep obj in frame
    if obj.x < obj.width/2
      vx = vx.abs
    elsif obj.x > FRAME_WIDTH - obj.width/2
      vx = -vx.abs
    end
      
    [vx, (obj.y > 100)? 0 : 1]
  end
  
  # Trajectory with these steps:
  #  - move forward
  #  - fix
  #  - go back
  def move_stop_go_back(obj)
    if obj.y < 150
      vy = 2
    else
      vy = 0
    end
    
    if Time.now - obj.creation_t > 6
      vy = -2
    end
    
    [0, vy]
  end
  
end
