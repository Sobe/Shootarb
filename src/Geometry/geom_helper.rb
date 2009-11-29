#!/usr/bin/env ruby

require 'rubygems'
require 'gosu'

# Geometrical utility methods.
module Geom_Helper

  # Geometrical distance between 2 points.
  def pts_distance(pt1, pt2)
    Gosu::distance(pt1[0], pt1[1], pt2[0], pt2[1])
  end
  
end

