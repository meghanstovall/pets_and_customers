require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'
require './lib/pet'

class CustomerTest < Minitest::Test

  def setup
    @joel = Customer.new("Joel", 2)
    @samson = Pet.new({name: "Samson", type: :dog})
    @lucy = Pet.new({name: "Lucy", type: :cat})
  end

  def test_it_exists
    assert_instance_of Customer, @joel
  end

  def test_it_has_attributes
    assert_equal "Joel", @joel.name
    assert_equal 2, @joel.id
    assert_equal [], @joel.pets
  end

  def test_can_adopt_pets
    @joel.adopt(@samson)
    @joel.adopt(@lucy)

    assert_equal [@samson, @lucy], @joel.pets
  end

  def test_outstanding_balance
    assert_equal 0, @joel.outstanding_balance

    @joel.adopt(@samson)
    @joel.adopt(@lucy)
    @joel.charge(@samson, "hair cut")

    assert_equal 40, @joel.outstanding_balance
    assert @samson.hair_cut

    @joel.charge(@samson, "bath")
    @joel.charge(@lucy, "nail trim")

    assert_equal 115, @joel.outstanding_balance
  end
end
