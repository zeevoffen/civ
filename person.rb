class Person  
  
  MAX_AGE = 150
  MAX_KIDS = 4
  MAX_AGE_TO_HAVE_KIDS = 50
  MIN_AGE_TO_HAVE_KIDS = 16
  CHANCE_TO_HAVE_KIDS = 0.5

  def initialize()  
    # Instance variables  
    @age = 0  
    @married = false
    @spouse = nil
    
    @kids = []
    @alive = true 
  end  
  
  def is_married?
    @married
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

  def add_kids
    
  end

  def update_age(age_inc_in_years)
    alive = false if need_to_die? 
    return unless is_alive? 
    age+=age_inc_in_years unless age>=MAX_AGE
    add_kids if can_have_kids?

  end

  def display  
    puts "I am of age #{@age} kids #{@kids}"  
  end  
end  