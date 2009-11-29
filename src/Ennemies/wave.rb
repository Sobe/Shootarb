#!/usr/bin/env ruby

require 'src/config'

# This class represents a wave of ennemies.
class Wave
  
  attr_reader :ennemies
  
  def initialize(window, x=nil, y=0)
    @window, @x, @y = window, x, y
    @x = rand*FRAME_WIDTH unless @x
    @ennemies = []
  end
  
  # Push ennemies of this wave into game.
  # To be called when entirely initialized and configured.
  def add_to_game
    @ennemies.each { |e| @window.ennemies.push(e) }
  end
  
end
