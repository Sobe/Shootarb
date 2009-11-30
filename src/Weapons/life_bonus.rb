#!/usr/bin/env ruby

require 'src/Weapons/bonus'
require 'src/trajectory'

include Trajectory

# Bonus giving one up.
class Life_Bonus < Bonus
  
  def initialize(window, player, x, y, trajectory=method(:bouncing_1_traj))
    super(window, player, x, y, trajectory)
    @vx = [2,-2][rand(2)]
    @vy = [2,-2][rand(2)]
    unless @@image
      @@image = Gosu::Image.new(@window, "media/l_bonus.bmp", false)
    end
  end
  
  # Give an additional life to player
  def give_bonus player
    player.add_1_life
  end
  
end
