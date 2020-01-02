class DayCare

  attr_reader :name, :customers, :feed_dog, :feed_cat, :feed_bear

  def initialize(name, feeding_charges)
    @name = name
    @customers = []
    @feed_dog = feeding_charges[:dog]
    @feed_cat = feeding_charges[:cat]
    @feed_bear = feeding_charges[:bear]
  end

  def add_customer(customer)
    @customers << customer
  end

  def find_customer(id)
    @customers.find {|customer| customer.id == id}
  end

  def unfed_pets
    all_pets.find_all {|pet| !pet.fed?}
  end

  def all_pets
    @customers.map {|customer| customer.pets}.flatten
  end

  def feed_unfed_pets
    @customers.each do |customer|
      customer.pets.each do |pet|
        if unfed_pets.include?(pet)
          charge(customer, pet)
        end
      end
    end

    unfed_pets.each {|pet| pet.feed}
  end

  def charge(customer, pet)
    if pet.type == :cat
      customer.outstanding_balance += @feed_cat
    elsif pet.type == :dog
      customer.outstanding_balance += @feed_dog
    elsif pet.type == :bear
      customer.outstanding_balance += @feed_bear
    end
  end
end
