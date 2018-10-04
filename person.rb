class Person  
  def initialize()  
    # Instance variables  
    @age = 0  
    @married = false
    @kids = []
    @alive = false
  end  
  
  def is_married?
    married
  end

  def is_alive?
    alive
  end

  def update_age(age_inc_in_years)
  end

  def display  
    puts "I am of age #{@age} kids #{@kids}"  
  end  
end  