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
    @weapons = [Standard_Weapon.new(@window, self)]
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
    if (@status == :crashed) and (Time.now - @last_crash_t > 1.5) and @lives > -1
      resurrect
    end
    
    # From resurrection to real life
    if (@status == :resurrecting) and (Time.now - @last_crash_t > 3.5)
      @status = :alive
    end
  end
  
  # Resurrect player.
  def resurrect
    @status = :resurrecting
    @x, @y = [FRAME_WIDTH/2, 4.0/5.0*FRAME_HEIGHT]
    @weapons = [Standard_Weapon.new(@window, self)]
  end
  
  # Standard draw() method according to current state.
  def draw
    case @status
    when :alive
      @normal_image.draw(@x - @normal_image.width / 2, @y - @normal_image.height / 2, ZOrder::Player)
    when :crashed
      @crash_image.draw(@x - @crash_image.width / 2, @y - @crash_image.height / 2, ZOrder::Player)
    when :resurrecting
      @normal_image.draw(@x - @normal_image.width / 2, @y - @normal_image.height / 2, ZOrder::Player) if (Time.now.to_f * 1000).to_i % 2 == 0
    end
  end
  
  def shoot
    if is_alive?
      @weapons.each { |w| w.shoot}
    end
  end
  
  # Called when player is touched by an <b>Ennemy_Bullet</b>.
  def touched
    crash
  end
  
  # Die, lose one life, this kind of things...
  def crash
    @status = :crashed
    @lives -= 1
    @last_crash_t = Time.now
  end
  
  # Return circular collision mask.
  def getCollisionMask
    Circle.new(@x, @y, [@width, @height].max/2.0)
  end
  
  # Is player alive?
  def is_alive?
    @status == :alive
  end
  
  # Is player resurrecting?
  def resurrecting?
    @status == :resurrecting
  end
  
  # Add one up.
  def add_1_life
    @lives += 1
  end
  
  # Add a weapon or get a points bonus if already has this one.
  def add_weapon(weapon)
    b = false
    @weapons.each {|w| b = (w.class == weapon.class)? true : b}
    if b
      # TODO Bug here: not always applied
      @score += 1000
    else
      @weapons << weapon  unless b
    end
  end
  
end