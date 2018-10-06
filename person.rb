#require_relative "civ.rb"

class Person  
  
  MAX_AGE = 150
  MAX_KIDS = 4
  MAX_AGE_TO_HAVE_KIDS = 50
  MIN_AGE_TO_HAVE_KIDS = 16
  CHANCE_TO_HAVE_KIDS = 0.5
  CHANCE_TO_MARRY = 0.8
  MIN_AGE_TO_MARRY = 18
  CHANCE_TO_BE_MALE = 0.5
  
  @@person_id = 0 
  @@total_persons = 0

  def initialize(civ)  
    puts "new Person"  
    @age = 0  
    @@person_id+=1
    @@total_persons+=1
    @id = @@person_id
    @is_male = rand < CHANCE_TO_BE_MALE
    @spouse = nil
    @kids = []
    @alive = true 
    @mother_civ = civ
  end  

  def add_kids
    @kids.push(@mother_civ.add_person)
    #puts "adding kids : ",@kids
  end

  def get_total_persons
    @@total_persons
  end
  
  def is_married?
    @spouse != nil
  end

  def is_alive?
    @alive
  end

  def need_to_die?
    rand < (age/MAX_AGE) or
    age >= MAX_AGE
  end
  def can_have_kids?
    age<=MAX_AGE_TO_HAVE_KIDS and 
    age>=MIN_AGE_TO_HAVE_KIDS and
    rand < CHANCE_TO_HAVE_KIDS
  end

  def dump_person
    print "person dump : "," id : ",@id, " age:",@age ," number of kids: ", @kids.size, " alive:",@alive
    #print "DUMP : ", self.to_s 
    #p self
    puts
  end

  def add_spouse
    @spouse = @mother_civ.find_match(@is_male) 
  end

  def ready_for_marriage
    @age>=MIN_AGE_TO_MARRY and
    rand < CHANCE_TO_MARRY
  end

  def update_age(age_inc_in_years)
    alive = false if need_to_die?
    @@total_persons-=1 unless alive 
    return unless is_alive? 
    age+=age_inc_in_years unless age>=MAX_AGE
    add_kids if can_have_kids?
    add_spouse unless is_married? or not ready_for_marriage
  end

  def display  
    puts "I am of age #{@age} kids #{@kids}"  
  end

    
end  