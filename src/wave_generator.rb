#!/usr/bin/env ruby

require 'src/Ennemies/wave'
require 'src/Ennemies/dummies_wave'
require 'src/Ennemies/simple_shooter'
require 'src/Ennemies/dummy_ennemy'
require 'src/Ennemies/traj_shooter'
require 'src/Ennemies/tracker_ennemy'

require 'src/Weapons/life_bonus'
require 'src/Weapons/dw_bonus'

require 'src/trajectory'

include Trajectory

# This class generate waves of ennemies.
class Wave_Generator
  
  attr_reader :current_level
  
  def initialize window
    @window = window
    set_level 1
    
    # Time length of each level
    # TODO rationalize here
    @@Level_Number = 5
    @@Levels_duration = [1, 60, 15, 15, 15, 50]
    @pause_at_beg = 1
    @bonus_given = false
  end
  
  # Method to be called in Window#update()
  def update
    if @current_level <= @@Level_Number
      if Time.now - @level_beg_t > @@Levels_duration[@current_level]
        set_level(@current_level+1)
      else
        method(@update_method).call  
      end
    end
    @current_level > @@Level_Number
  end
  
  def set_level level
    @current_level = level
    @update_method = "update_level_#{@current_level}"
    @level_beg_t = Time.now
    @bonus_given = false
  end
  
  #
  # UPDATE METHODS
  #
  
  # Nil method for border cases.
  def update_level_
  end
  
  def update_level_1
    if Time.now - @level_beg_t > @pause_at_beg
      @window.ennemies.push(Dummy_Ennemy.new(@window, rand*FRAME_WIDTH, 0)) if rand(80) == 0
      @window.ennemies.push(Tracker_Ennemy.new(@window, @window.player, rand*FRAME_WIDTH, 0)) if rand(80) == 0
      if (rand(60) == 0 and not @bonus_given)
        @window.bonuses.push(DW_Bonus.new(@window, @window.player, rand*FRAME_WIDTH, 0))
        @bonus_given = true
      end
    end
  end
  
  def update_level_2
    if Time.now - @level_beg_t > @pause_at_beg
      @window.ennemies.push(Simple_Shooter.new( @window, @window.player, rand*FRAME_WIDTH, 0)) if rand(80) == 0
      @window.ennemies.push(Tracker_Ennemy.new(@window, @window.player, rand*FRAME_WIDTH, 0)) if rand(80) == 0
    end
  end
  
  def update_level_3
    if Time.now - @level_beg_t > @pause_at_beg
      Dummies_Wave.new(@window) if rand(200) == 0
      @window.ennemies.push(Tracker_Ennemy.new(@window, @window.player, rand*FRAME_WIDTH, 0)) if rand(80) == 0
    end
  end
  
  def update_level_4
    if Time.now - @level_beg_t > @pause_at_beg
      traj = method(:y_accel_traj)
      @window.ennemies.push(Traj_Shooter.new(@window, @window.player, rand*FRAME_WIDTH, rand(10), traj)) if rand(80) == 0
      @window.ennemies.push(Tracker_Ennemy.new(@window, @window.player, rand*FRAME_WIDTH, 0)) if rand(80) == 0
    end
  end
  
  def update_level_5
    if Time.now - @level_beg_t > @pause_at_beg
      update_level_1
      update_level_2
      update_level_3
      update_level_4
    end
  end
  
end
