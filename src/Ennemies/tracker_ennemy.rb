#!/usr/bin/env ruby

require 'src/trajectory'

include Trajectory

# An ennemy following the player
class Tracker_Ennemy < Ennemy_With_Traj
  
  attr_reader :player
  
  def initialize(window, player, x, y)
    super(window, x, y, method(:tracking_traj))
    
    # Dimensions
    @width, @height = 20, 20  
    # Score value
    @score_pts = 30
    
    # Initial horizontal/vertical velocity.
    @vx = 0 
    @vy = 1
    
    @player = player
    
    # TODO use class variable instead
    @image = Gosu::Image.new(@window, "media/tracker.bmp", false)
    @colors = [0xff780000, 0xff4f4242]
  end
  
end
