require_relative "person.rb"

class Civ
	
	def initialize
	  puts "new civ" 
	  @p = []
	  @p.push(Person.new(self))
    end
    
    def dump_civ
    	puts "civ :",@p.each {|per| per.dump_person}
    end

    def add_person
      new_person  = Person.new(self)
	  @p.push(new_person)
	  new_person
    end

    def get_person(i)
    	@p[i]
    end

    def tmp
    	787
    end

end

c = Civ.new()
c.get_person(0).add_kids
puts c.dump_civ

