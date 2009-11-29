#!/usr/bin/env ruby

require 'src/Weapons/bullet'

# Standard/basic player's weapon.
class Standard_Weapon
  
  def initialize(window, player)
    @window, @player = window, player
    
    # Behavior
    @period = 0.3
    @vx, @vy = 0, 7
    @last_shot = Time.now
    
  end
  
  def add_bullets
    #puts "@player[x, y] = [#{@player.x},#{@player.y}]"
    @window.bullets <<  Std_Bullet.new(@window, @player, @player.x, @player.y - @player.height/2, @vx, @vy)
  end
  
  def shoot
    if Time.now - @last_shot > @period
      add_bullets
      @last_shot = Time.now
    end
  end
  
    # Specific bullet.
  class Std_Bullet < Bullet
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
