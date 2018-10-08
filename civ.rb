require_relative "person.rb"
require 'logger'

$logger = Logger.new("log.txt")
$logger.level = Logger::INFO


NUM_INITIAL_PERSONS = 100

class Civ
	
	def initialize
	  $logger.info "new civ" 
	  @p = []
	  (1..NUM_INITIAL_PERSONS).each {@p.push(Person.new(self))}
      @@year = 0
      @civ_total_alive = NUM_INITIAL_PERSONS
      @civ_total_dead = 0
    end
    
    def find_match(for_male)
      @p.each  do |per|  
            $logger.info("find_match : searching match for male? #{for_male} cehcking #{per} age #{per.get_age} male? #{per.is_male?} is married ? #{per.is_married?}")
            if   per.ready_for_marriage and
                ((per.is_male?  and not for_male) or
                 (not per.is_male?  and for_male)) then
                return per
            end
        end
        return nil
    end

    def dump_civ
    	@p.each {|per| per.dump_person}
    	$logger.info "total population:#{get_total_civ}"
        $logger.info "avg kids num : #{avg_kids_per_family}"
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
    	n_years.times do |iter|
            $logger.info "currently in year:#{@@year}"
            @p.each {|per| per.update_age(1)}
            update_civ_stat
            $logger.info "Totaly born this year:#{@born_last_year} , died this year #{@died_this_year}, Total alive:#{@civ_total_alive}"
            @@year+=1
        end
    end

    def update_civ_stat
        total_alive,total_dead = 0,0
        @p.each do |per|
            total_alive+=1 if per.is_alive?
            total_dead+=1 if not per.is_alive?    
        end
        @born_last_year = total_alive - @civ_total_alive 
        @died_this_year = total_dead - @civ_total_dead
        @civ_total_dead = total_dead
        @civ_total_alive = total_alive
    end
       

    def avg_kids_per_family
        total=0
        @p.each {|x| total+=x.family_size}
        num_families = @p.count {|x| x.is_family}
        #puts "num families: ",num_families, " total kids ",total
        total.to_f/num_families.to_f
    end

end


