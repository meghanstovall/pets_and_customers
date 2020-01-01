class Groomer

  attr_reader :name, :customers

  def initialize(name)
    @name = name
    @customers = []
  end

  def add_customer(customer)
    @customers << customer
  end

  def customers_with_balance
    @customers.find_all {|customer| customer.outstanding_balance > 0}
  end

  def number_of_pets(pet_type)
    all_pets = @customers.map {|customer| customer.pets}.flatten

    all_pets.count {|pet| pet.type == pet_type}
  end

  def charge(customer, pet, what_for)
    customer.charge(pet, what_for)
  end
end
