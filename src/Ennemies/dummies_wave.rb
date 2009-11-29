#!/usr/bin/env ruby

require 'src/Ennemies/wave'
require 'src/Ennemies/dummy_ennemy'

# A wave of Dummy_Ennemies.
class Dummies_Wave < Wave
  
  def initialize(window, x=nil, y=0)
    super(window, x, y)
    
    proto = Dummy_Ennemy.new(@window, 0, 0)
    offset_X = proto.width + 5
    proto = nil
    
    5.times do |t|
      @ennemies.push(Dummy_Ennemy.new(@window, @x + t*offset_X, @y))
    end
    
    add_to_game
  end
  
end
