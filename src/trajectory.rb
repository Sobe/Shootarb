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
  def test_traj(obj)
    [0, obj.vy + 0.1]
  end
  
  def tracking_traj(obj)
    vx = (obj.player.x - obj.x) / pts_distance([obj.player.x, obj.player.y], [obj.x, obj.y])
    vy = (obj.player.y - obj.y) / pts_distance([obj.player.x, obj.player.y], [obj.x, obj.y])
    [vx, vy]
  end
  
end
