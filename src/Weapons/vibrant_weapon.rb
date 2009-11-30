#!/usr/bin/env ruby

require 'src/Weapons/bullet_with_traj'

require 'src/trajectory'

include Trajectory

# A divergent 2 shots player's weapon.
class Vibrant_Weapon
  
  def initialize(window, player)
    @window, @player = window, player
    
    # Behavior
    @period = 0.2
    @vx, @vy = 2, 5
    @last_shot = Time.now
  end
  
  # Add bullets in window.
  def add_bullets
    @window.bullets <<  Vibrant_Bullet.new(@window, @player, @player.x, @player.y - @player.height/2.0)
  end
  
  # Shoot bullets.
  def shoot
    if Time.now - @last_shot > @period
      add_bullets
      @last_shot = Time.now
    end
  end
  
  # Specific bullet.
  class Vibrant_Bullet < Bullet_With_Traj
    def initialize(window, player, x, y, traj=method(:few_random_traj))
      super(window, player, x, y, traj)
      
      # Dimensions
      @width, @height = 10, 10
      
      @image = Gosu::Image.new(@window, "media/vibrant_pbullet.bmp", false)
    end
    
    def draw
        @image.draw(@x - @image.width / 2, @y - @image.height / 2, ZOrder::Player)
    end
  end
  
end

