#!/usr/bin/env ruby

require 'src/Weapons/bullet'

# A divergent 2 shots player's weapon.
class Divergent_Weapon
  
  def initialize(window, player)
    @window, @player = window, player
    
    # Behavior
    @period = 0.3
    @vx, @vy = 2, 5
    @last_shot = Time.now
    
  end
  
  # Add bullets in window.
  def add_bullets
    @window.bullets <<  DW_Bullet.new(@window, @player, @player.x, @player.y - @player.height/2.0, @vx, @vy)
    @window.bullets <<  DW_Bullet.new(@window, @player, @player.x, @player.y - @player.height/2.0, -@vx, @vy)
  end
  
  # Shoot bullets.
  def shoot
    if Time.now - @last_shot > @period
      add_bullets
      @last_shot = Time.now
    end
  end
  
  # Specific bullet.
  class DW_Bullet < Bullet
    def initialize(window, player, x, y, vx, vy)
      super(window, player, x, y, vx, vy)
      
      # Dimensions
      @width, @height = 10, 10
      
      @image = Gosu::Image.new(@window, "media/std_pbullet.bmp", false)
    end
    
    def draw
        @image.draw(@x - @image.width / 2, @y - @image.height / 2, ZOrder::Player)
    end
  end
  
end
