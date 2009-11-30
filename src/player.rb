#!/usr/bin/env ruby

require 'src/zorder'
require 'src/config'

require 'src/Weapons/standard_weapon'
require 'src/Weapons/divergent_weapon'
require 'src/Weapons/vibrant_weapon'

include Config

# This class represents the player's spacecraft
# and also contains associated score.
class Player
  Speed = 6
  
  attr_accessor :score, :hp, :lives, :width, :height
  attr_reader :x, :y, :status

  def initialize(window, x, y)
    @window = window
    
    # Images
    @normal_image = Gosu::Image.new(@window, "media/Starfighter_with_collision_mask_V2.bmp", false)
    # TODO Hey! I need an animation or something!
    @crash_image = Gosu::Image.new(@window, "media/Starfighter_crash.BMP", false)
    
    @status = :alive
    @x, @y = x, y
    @width, @height = 50, 50
    @score = 0
    @lives = 3
    @hp = 100
    @last_bullet_time = Time.now
    @weapons = [Standard_Weapon.new(@window, self), Vibrant_Weapon.new(@window, self)]
  end

  def move_left
    @x = [@x - Speed, @width/2].max
  end
  
  def move_right
    @x = [@x + Speed, FRAME_WIDTH - @width/2].min
  end
  
  def accelerate
    @y = [@y - Speed, @height/2].max
  end
  
  def brake
    @y = [@y + Speed, FRAME_HEIGHT - @height / 2].min
  end
  
  # Standard update method.
  def update
    # From death to live again...
    if (!is_alive?) and (Time.now - @last_crash_t > 1.5) and @lives > -1
      # Resurect
      @x, @y = [400, 500]
      @status = :alive
    end
  end
  
  def draw
    case @status
    when :alive
      @normal_image.draw(@x - @normal_image.width / 2, @y - @normal_image.height / 2, ZOrder::Player)
    when :crashed
      @crash_image.draw(@x - @crash_image.width / 2, @y - @crash_image.height / 2, ZOrder::Player)
    end
  end
  
  def shoot
    if is_alive?
      @weapons.each { |w| w.shoot}
    end
  end
  
  # Called when player is touched by an <b>Ennemy_Bullet</b>.
  def touched
    #@hp -= 1
    crash
  end
  
  def crash
    @status = :crashed
    @lives -= 1
    @last_crash_t = Time.now
  end
  
  # Return circular collision mask.
  def getCollisionMask
    Circle.new(@x, @y, [@width, @height].max/2.0)
  end
  
  def is_alive?
    @status == :alive
  end
  
  # Add one up.
  def add_1_life
    @lives += 1
  end
  
  def add_weapon(weapon)
    b = false
    @weapons.each {|w| b = (w.class == weapon.class)? true : b}
    @weapons << weapon  unless b
  end
  
end