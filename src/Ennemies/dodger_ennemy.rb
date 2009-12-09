#!/usr/bin/env ruby

require 'src/Ennemies/traj_shooter'
require 'src/trajectory'

include Trajectory

class Dodger_Ennemy < Traj_Shooter
  
  def initialize(window, player, x, y)
    super(window, player, x, y, method(:dodge_traj))
    
    @image = Gosu::Image.new(@window, "media/dodger_ennemy.png", false)
    @colors = [0xff6b3751, 0xff780000, 0xffbc7373]
  end
  
end
