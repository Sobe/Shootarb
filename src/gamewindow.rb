#!/usr/bin/env ruby

require 'rubygems'
require 'gosu'
require 'gl'
require 'glu'

require 'src/config'
require 'src/player'
require 'src/wave_generator'
require 'src/wave_generator_test'
require 'src/Ennemies/dummy_ennemy'
require 'src/Ennemies/simple_shooter'
require 'src/Ennemies/traj_shooter'
require 'src/Ennemies/dummies_wave'
#require 'src/glbackground'

include Gl
include Glu

include Config

# Main window of the game.
class GameWindow < Gosu::Window
  
  attr_reader :ennemies, :player, :particles, :bonuses
  attr_accessor :bullets, :e_bullets
  
  # Play in Test Mode if testmode == true
  def initialize(testmode)
    super(FRAME_WIDTH, FRAME_HEIGHT, false)
    self.caption = "Shoota"
    
    #@gl_background = GLBackground.new(self)
    #@background_image = Gosu::Image.new(self, "media/Space.png", true)
    
    # Lists of sprites elements
    @bullets = []
    @e_bullets = []
    @ennemies = []
    @bonuses = []
    @particles = []
    
    # Launch player
    @player = Player.new(self, 400, 500)
    
    # Create Waves generator
    if testmode
      @w_generator = Wave_Generator_Test.new self
    else
      @w_generator = Wave_Generator.new self
    end

    @finished = false
    
    # Fonts for textual elements
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @big_font = Gosu::Font.new(self, Gosu::default_font_name, 52)
    
    # other constants
    # TODO use Image.from_text() instead
    @GAME_OVER_X = (FRAME_WIDTH - @big_font.text_width("GAME OVER"))/2.0
    @GAME_OVER_Y = (FRAME_HEIGHT - @big_font.text_width("GAME OVER")/9.0)/2.0
    @THE_END_X = (FRAME_WIDTH - @big_font.text_width("THE END"))/2.0
    @THE_END_Y = (FRAME_HEIGHT - @big_font.text_width("THE END")/9.0)/2.0
    
  end

  # Override standard <b>update()</b> method.
  def update
    # Update player
    # TODO externalize this part PlayerCtrl
    if @player.status == :alive
      @player.move_left if button_down? Gosu::Button::KbLeft or button_down? Gosu::Button::GpLeft
      @player.move_right if button_down? Gosu::Button::KbRight or button_down? Gosu::Button::GpRight
      @player.accelerate if button_down? Gosu::Button::KbUp or button_down? Gosu::Button::GpUp
      @player.brake if button_down? Gosu::Button::KbDown or button_down? Gosu::Button::GpDown
      @player.shoot if button_down? Gosu::Button::KbZ or button_down? Gosu::GpButton0
    end
    @player.update
    
    # Check touching bullets
    @bullets.reject! { |b| b.touch? @ennemies }
    @e_bullets.reject! { |b| b.touch? @player }
    
    
    # Update bullets and ennemies
    # Remove all objects whose update method returns false. 
    @bullets.reject! { |o| o.update == false }
    @e_bullets.reject! { |o| o.update == false }
    @ennemies.reject! { |e| e.update == false }
    @bonuses.reject! { |b| b.update == false }
    @particles.reject! { |p| p.update == false }
    
    
    #@gl_background.scroll
    
    # Generate new ennemies
    @finished = @w_generator.update
  end

  # Override standard <b>draw()</b> method.
  def draw
    # gl will execute the given block in a clean OpenGL environment, then reset
    # everything so Gosu's rendering can take place again.
    
    #gl do
    #  glClearColor(0.0, 0.2, 0.5, 1.0)
    #  glClearDepth(0)
    #  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    # 
    #  @gl_background.exec_gl
    #end
    #@background_image.draw(0, 0, ZOrder::Background)
    
    @bullets.each { |o| o.draw }
    @e_bullets.each { |o| o.draw }
    @ennemies.each{|e| e.draw}
    @bonuses.each{|b| b.draw}
    @particles.each{|p| p.draw}
    
    @player.draw
    
    # TODO externalize UI methods
    # Score
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    # Player's lives count
    @font.draw("LIVES: #{(@player.lives > -1)? @player.lives : "GAME OVER"}", 10, 30, ZOrder::UI, 1.0, 1.0, 0xffff0000)
    # Current level
    @font.draw("LEVEL: #{@w_generator.current_level}", 10, 50, ZOrder::UI, 1.0, 1.0, 0xffff0000)
    
    # Game Over Label
    if @player.lives < 0
      @big_font.draw("GAME OVER", @GAME_OVER_X, @GAME_OVER_Y, ZOrder::UI, 1.0, 1.0, 0xffff0000)
    end
    # End game label
    if @finished
      @big_font.draw("THE END", @GAME_OVER_X, @GAME_OVER_Y, ZOrder::UI, 1.0, 1.0, 0xffff0000)
    end
  end

  # Special behavior when a button is pressed.
  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
end