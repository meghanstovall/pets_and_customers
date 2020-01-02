class Customer

  attr_reader :name, :id, :pets
  attr_accessor :outstanding_balance

  def initialize(name, id)
    @name = name
    @id = id
    @pets = []
    @outstanding_balance = 0
  end

  def adopt(pet)
    @pets << pet
  end

  def charge(pet, what_for)
    if what_for == "hair cut"
      @outstanding_balance += 40
      pet.get_hair_cut
    elsif what_for == "bath"
      @outstanding_balance += 60
      pet.get_bath
    elsif what_for == "nail trim"
      @outstanding_balance += 15
      pet.get_nails_trimmed
    end
  end
end
