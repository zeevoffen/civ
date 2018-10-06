require_relative "person.rb"

class Civ
	
	def initialize
	  puts "new civ" 
	  @p = []
	  @p.push(Person.new(self))
    end
    
    def find_match(for_male)
      @p.each {|per| return per if 
                per.ready_for_marriage and
                per.is_male != for_male}
    end

    def dump_civ
    	@p.each {|per| per.dump_person}
    	print "total population:",get_total_civ
    	puts
    end

    def get_total_civ
    	@p[0].get_total_persons
    end

    def add_person
      new_person  = Person.new(self)
	  @p.push(new_person)
	  new_person
    end

    def get_person(i)
    	@p[i]
    end

    def advance_n_years(n_years)
    	
    end

end

c = Civ.new()
c.get_person(0).add_kids
c.dump_civ

