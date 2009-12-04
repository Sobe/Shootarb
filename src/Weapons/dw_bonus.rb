#!/usr/bin/env ruby

require 'src/Weapons/bonus'
require 'src/trajectory'

include Trajectory

# Bonus giving Divergent Weapon.
class DW_Bonus < Bonus
  
  def initialize(window, player, x, y, trajectory=method(:bouncing_1_traj))
    super(window, player, x, y, trajectory)
    @vx = [2,-2][rand(2)]
    @vy = [2,-2][rand(2)]
    @image = Gosu::Image.new(@window, "media/dw_bonus.bmp", false)
  end
  
  # Give divergent weapon to the player.
  def give_bonus player
    player.add_weapon(Divergent_Weapon.new(@window, player))
  end
  
end
