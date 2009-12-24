#!/usr/bin/env ruby

require 'src/Ennemies/Ennemy_With_Traj'

require 'src/Trajectory'

include Trajectory

# Big shooter ennemy.
class Tank_Shooter < Ennemy_With_Traj
  
  def initialize(window, player, x, y)
    super(window, x, y, method(:move_stop_go_back))
    
    # Dimensions
    @width, @height = 100, 100  
    # Score value
    @score_pts = 200
    # Health
    @hp = 50
    
    # Initial horizontal/vertical velocity.
    @vx = 0 
    @vy = 1
    
    @player = player
    
    @image = Gosu::Image.new(@window, "media/big_ennemy.png", false)
    
    # Shoot timer
    @last_shoot_1 = Time.now - rand(30)
    @last_shoot_2 = Time.now - rand(30)
  end
  
  def update
    res = super
    
    if @vy == 0
      shoot_1
      if (@x - @player.x).abs < 25
        shoot_2
      end
    end
    
    # Returns false to be removed if out of frame or crashed on player
    res
  end
  
  # Shoot with weapon 1.
  def shoot_1
    if Time.now - @last_shoot_1 > 0.5
      @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, @x, @y, -2, 4)
      @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, @x, @y, 0, 4)
      @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, @x, @y, 2, 4)
      @last_shoot_1 = Time.now
    end
  end
  
  # Shoot with weapon 2.
  def shoot_2
    if Time.now - @last_shoot_1 > 0.05
      @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, @x - 28, @y, 0, 7)
      @window.e_bullets <<  Ennemy_Bullet.new(@window, @player, @x + 28, @y, 0, 7)
      @last_shoot_1 = Time.now
    end
  end
  
  # When touched by a bullet.
  def touched_by bullet
    ([@width, @height].max/3).times do
      p_vx = rand(100)/10.0 - 5
      p_vy = rand(100)/10.0 - 5
      #@window.particles << Particle.new(@window, @x + rand(@width) - @width/2, @y + rand(@height) - @height/2, p_vx, p_vy)
      @window.particles << Live_Particle.new(@window, bullet.x + rand(@width) - @width/2, bullet.y + rand(@height) - @height/2, p_vx, p_vy, @colors.rand_in, 1 + rand)
    end
    damage bullet.damage
  end
  
end
