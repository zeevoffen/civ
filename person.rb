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
    @age = 0  
    @@person_id+=1
    @@total_persons+=1
    @id = @@person_id
    @is_male = rand < CHANCE_TO_BE_MALE
    @spouse = nil
    @kids = []
    @alive = true 
    @mother_civ = civ
    $logger.info "new person created with id #{@id} male? #{@is_male}"
  end  

  def add_kids
    @kids.push(@mother_civ.add_person)
    #puts "adding kids to id #{@id} at age #{@age}"
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
    rand < (@age.to_f/(2*MAX_AGE.to_f)) or
    @age >= MAX_AGE
  end
  def can_have_kids?
    @age<=MAX_AGE_TO_HAVE_KIDS and 
    @age>=MIN_AGE_TO_HAVE_KIDS and
    rand < CHANCE_TO_HAVE_KIDS and
    is_married? and
    @kids.size < MAX_KIDS
  end

  def is_male?
     @is_male
  end

  def dump_person
    $logger.info "person dump :  id:#{@id} age:#{@age} number of kids: #{@kids.size} alive:#{@alive}"
  end

  def add_spouse
    @spouse = @mother_civ.find_match(@is_male) 
    $logger.info "spouse search for #{self} yield:#{@spouse}"
  end

  def get_age
    @age
  end

  def ready_for_marriage
    @age>=MIN_AGE_TO_MARRY and
    rand < CHANCE_TO_MARRY and
    not is_married?
  end

  def family_size
    @kids.size 
  end

  def is_family
    @kids.size>0 or
    not is_married?
  end

  def update_age(age_inc_in_years)
    return unless is_alive?
    @alive = false if need_to_die?
    @@total_persons-=1 unless @alive
    $logger.info "Id #{@id} died at age #{@age}" unless is_alive?
    return unless is_alive? 
    @age+=age_inc_in_years unless @age>=MAX_AGE
    #puts "age->#{@age}"
    $logger.info "update_age==>#{self} current age : #{@age}"
    add_kids if can_have_kids?
    add_spouse unless is_married? or not ready_for_marriage
  end

 

    
end  