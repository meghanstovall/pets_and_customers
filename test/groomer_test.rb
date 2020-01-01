require 'minitest/autorun'
require 'minitest/pride'
require './lib/groomer'
require './lib/customer'
require './lib/pet'

class GroomerTest < Minitest::Test

  def setup
    @groomer = Groomer.new("Petco")
    @joel = Customer.new("Joel", 2)
    @sam = Customer.new("Sam", 3)
    @samson = Pet.new({name: "Samson", type: :dog})
    @duece = Pet.new({name: "Duece", type: :dog})
    @ozzie = Pet.new({name: "Ozzie", type: :cat})
    @harley = Pet.new({name: "Harley", type: :bear})
  end

  def test_it_exists
    assert_instance_of Groomer, @groomer
  end

  def test_it_has_attributes
    assert_equal "Petco", @groomer.name
    assert_equal [], @groomer.customers
  end

  def test_can_add_customers
    @groomer.add_customer(@joel)
    @groomer.add_customer(@sam)

    assert_equal [@joel, @sam], @groomer.customers
  end

  def test_find_customers_with_balance
    @groomer.add_customer(@joel)
    @groomer.add_customer(@sam)
    @joel.adopt(@samson)
    @joel.adopt(@duece)
    @joel.charge(@samson, "bath")
    @joel.charge(@duece, "nail trim")

    assert_equal [@joel], @groomer.customers_with_balance

    @sam.adopt(@ozzie)
    @sam.charge(@samson, "bath")

    assert_equal [@joel, @sam], @groomer.customers_with_balance
  end

  def test_can_count_num_pets_by_type
    @joel.adopt(@samson)
    @joel.adopt(@harley)
    @sam.adopt(@duece)
    @sam.adopt(@ozzie)
    @groomer.add_customer(@joel)
    @groomer.add_customer(@sam)

    assert_equal 0, @groomer.number_of_pets(:horse)
    assert_equal 1, @groomer.number_of_pets(:bear)
    assert_equal 1, @groomer.number_of_pets(:cat)
    assert_equal 2, @groomer.number_of_pets(:dog)
  end

  def test_can_charge_customers
    @joel.adopt(@samson)
    @joel.adopt(@harley)
    @sam.adopt(@duece)
    @sam.adopt(@ozzie)
    @groomer.add_customer(@joel)
    @groomer.add_customer(@sam)

    @groomer.charge(@joel, @samson, "hair cut")
    @groomer.charge(@sam, @ozzie, "bath")

    assert_equal [@joel, @sam], @groomer.customers_with_balance
    assert_equal 40, @joel.outstanding_balance
    assert_equal 60, @sam.outstanding_balance
  end
end
