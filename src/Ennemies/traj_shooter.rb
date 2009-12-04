#!/usr/bin/env ruby

require 'src/Ennemies/ennemy_with_traj'
require 'src/Ennemies/ennemy_bullet'

# A naive shooting Ennemy, with a user defined trajectory.
class Traj_Shooter < Ennemy_With_Traj
  
  def initialize(window, player, x, y, trajectory)
    super(window, x, y, trajectory)
    
    # Dimensions
    @width, @height = 50, 50  
    # Score value
    @score_pts = 50
    
    # Initial horizontal/vertical velocity.
    @vx = 0 
    @vy = 1
    
    @player = player
    
    @image = Gosu::Image.new(@window, "media/RedEnnemy.png", false)
    
    # Shoot timer
    @last_shoot = Time.now - rand(30)
  end
  
  def update
    res = super
    
    if Time.now - @last_shoot > 1.3
      shoot()
      @last_shoot = Time.now
    end
    
    # Returns false to be removed if out of frame or crashed on player
    res
  end
  
  def shoot
    @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, @x, @y, 0, 7)
    @last_bullet_time = Time.now
  end
  
end
