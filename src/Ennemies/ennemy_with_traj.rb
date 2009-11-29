#!/usr/bin/env ruby

require 'src/Ennemies/Ennemy'

class Ennemy_With_Traj < Ennemy
  
  attr_reader :creation_t
  
   def initialize(window, x, y, trajectory)
    super(window, x, y)
    
    @trajectory = trajectory
    @creation_t = Time.now
    
  end
  
  # Velocities are modified by this method via
  # the call to <b>@trajectory</b> method.
  def apply_traj
    @vx, @vy = @trajectory.call(self)
  end
  
  def update
    apply_traj
    super
  end
  
end
