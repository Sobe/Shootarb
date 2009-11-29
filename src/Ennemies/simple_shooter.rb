#!/usr/bin/env ruby

require 'src/Ennemies/ennemy'
require 'src/Ennemies/ennemy_bullet'

# A naive shooting Ennemy
class Simple_Shooter < Ennemy
  
  def initialize(window, player, x, y)
    super(window, x, y)
    
    # Dimensions
    @width, @height = 50, 50  
    # Score value
    @score_pts = 50
    
    # Horizontal/vertical velocity.
    @vx = 0 
    @vy = 1
    
    @player = player
    
    @image = Gosu::Image.new(@window, "media/RedEnnemy.bmp", false)
    
    # Shoot timer
    @last_shoot = Time.now
  end
  
  def update
    @x += @vx
    @y += @vy
    
    # Todo puts all these middle things of update in "actions[method1, method2...]"
    if Time.now - @last_shoot > 1.3
      shoot()
      @last_shoot = Time.now
    end
    
    # Returns false to be removed if out of frame or crashed on player
    inside_game_area? and !touch?(@window.player)
  end
  
  def shoot
    @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, @x, @y)
    @last_bullet_time = Time.now
  end
  
end
