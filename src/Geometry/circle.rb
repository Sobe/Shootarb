#!/usr/bin/env ruby

require 'src/Geometry/geom_helper'
require 'rubygems'
require 'gosu'

include Geom_Helper

# Geometrical circle
class Circle
  
  attr_reader :center, :radius
  
  # Circle of center ['x', 'y'] and radius 'r'
  def initialize(x, y, r)
    @center = [x, y]
    @radius = r
  end
  
  # Does this circle intersect another one?
  def intersects_with?(o_circle)
    pts_distance(@center, o_circle.center) < @radius + o_circle.radius
  end  
  
end
