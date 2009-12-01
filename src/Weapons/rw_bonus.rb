#!/usr/bin/env ruby

require 'src/Weapons/bonus'
require 'src/Weapons/vibrant_weapon'
require 'src/trajectory'

include Trajectory

# Bonus giving Radiant Weapon.
class VW_Bonus < Bonus
  
  def initialize(window, player, x, y, trajectory=method(:bouncing_1_traj))
    super(window, player, x, y, trajectory)
    @vx = [2,-2][rand(2)]
    @vy = [2,-2][rand(2)]
    unless @@image
      @@image = Gosu::Image.new(@window, "media/vw_bonus.bmp", false)
    end
  end
  
  # Give radiant weapon to the player.
  def give_bonus player
    player.add_weapon(Vibrant_Weapon.new(@window, player))
  end
  
end
