#!/usr/bin/env ruby

# Extension of Ruby Array class.
class Array
  
  # Return a random element of this array.
  def rand_in
    self[rand(self.size)]
  end
  
end
