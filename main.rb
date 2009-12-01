#!/usr/bin/env ruby

$:.unshift(File.dirname($0))
Dir.chdir($:.first)

require 'src/gamewindow.rb'

# Patch for test mode
test = ARGV.include? "test"

window = GameWindow.new(test)
window.show