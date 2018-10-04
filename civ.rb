require_relative "person.rb"

class Civ
	def initialize
	  puts "new civ" 
	  @p = []
	  @p.push(Person.new(self))
    end
    def tmp
    	787
    end
end

c = Civ.new()
puts c
