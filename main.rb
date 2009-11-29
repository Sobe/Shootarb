#!/usr/bin/env ruby

$:.unshift(File.dirname($0))
Dir.chdir($:.first)

require 'src/gamewindow.rb'

window = GameWindow.new
window.show