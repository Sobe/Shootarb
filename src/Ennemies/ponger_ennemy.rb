#!/usr/bin/env ruby

require 'gosu'

require 'src/Ennemies/ennemy_with_traj'
require 'src/Ennemies/ennemy_bullet'

require 'src/trajectory'

include Trajectory

# An ennemy boucing bullets when red and vulnerable when green.
class Ponger_Ennemy < Ennemy_With_Traj
  

  
  def initialize(window, player, x, y, traj=method(:bouncing_1_traj))
    super(window, x, y, traj)
    
    # TODO externalize it
    # Images
    @@img_red = Gosu::Image.new(@window, "media/ponger_red.png", false)
    @@img_green = Gosu::Image.new(@window, "media/ponger_green.png", false)
    # Delay between 2 state switches
    @@delay = 3
    
    # Initial velocity
    @vx = rand
    @vy = rand
    
    # Dimensions
    @width, @height = 20, 20
    
    # Score
    @score_pts = 100
    
    # State
    @last_switch_t = Time.now
    @is_red = [true, false][rand(2)]
  end
  
  # Return image to be used according to current state.
  def current_img
    if @is_red
      @@img_red
    else
      @@img_green
    end
  end
  
  # Bullets bounce on it when red.
  def touched_by bullet
    if @is_red
      @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, bullet.x, bullet.y, -bullet.vx, -bullet.vy)
    else
      super(bullet)
    end
  end
  
  # Update method with state switch management.
  def update
    switch_state if (Time.now - @last_switch_t) > @@delay
    super
  end
  
  # Standard <b>draw()</b> method.
  def draw
    current_img.draw(@x - current_img.width / 2, @y - current_img.height / 2, ZOrder::Player)
  end
  
  # Switch current state.
  def switch_state
    @is_red = !@is_red
    @last_switch_t = Time.now
  end
  
end
