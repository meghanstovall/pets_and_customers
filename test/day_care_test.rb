require 'minitest/autorun'
require 'minitest/pride'
require './lib/day_care'
require './lib/customer'
require "./lib/pet"

class DayCareTest < Minitest::Test

  def setup
    @day_care = DayCare.new("Paws Day Care", {dog: 20, cat: 15, bear: 80})
    @joel = Customer.new("Joel", 2)
    @sam = Customer.new("Sam", 3)
    @aidan = Customer.new("Aidan", 4)
    @samson = Pet.new({name: "Samson", type: :dog})
    @duece = Pet.new({name: "Duece", type: :dog})
    @ozzie = Pet.new({name: "Ozzie", type: :cat})
    @harley = Pet.new({name: "Harley", type: :bear})
  end

  def test_it_exists
    assert_instance_of DayCare, @day_care
  end

  def test_it_has_attributes
    assert_equal "Paws Day Care", @day_care.name
    assert_equal [], @day_care.customers
    assert_equal 15, @day_care.feed_cat
    assert_equal 20, @day_care.feed_dog
    assert_equal 80, @day_care.feed_bear
  end

  def test_can_add_customers
    @day_care.add_customer(@joel)

    assert_equal [@joel], @day_care.customers

    @day_care.add_customer(@sam)

    assert_equal [@joel, @sam], @day_care.customers
  end

  def test_find_customer_by_id
    @day_care.add_customer(@joel)
    @day_care.add_customer(@sam)
    @day_care.add_customer(@aidan)

    assert_equal @joel, @day_care.find_customer(2)
    assert_equal @sam, @day_care.find_customer(3)
    assert_equal @aidan, @day_care.find_customer(4)
  end

  def test_find_all_pets
    @joel.adopt(@samson)
    @joel.adopt(@ozzie)
    @sam.adopt(@duece)
    @sam.adopt(@harley)

    @day_care.add_customer(@joel)
    @day_care.add_customer(@sam)

    assert_equal [@samson, @ozzie, @duece, @harley], @day_care.all_pets
  end

  def test_find_all_unfed_pets
    @joel.adopt(@samson)
    @joel.adopt(@ozzie)
    @sam.adopt(@duece)
    @sam.adopt(@harley)

    @day_care.add_customer(@joel)
    @day_care.add_customer(@sam)

    assert_equal [@samson, @ozzie, @duece, @harley], @day_care.unfed_pets

    @samson.feed

    assert_equal [@ozzie, @duece, @harley], @day_care.unfed_pets

    @ozzie.feed

    assert_equal [@duece, @harley], @day_care.unfed_pets
  end

  def test_feed_all_unfed_pets
    @joel.adopt(@samson)
    @joel.adopt(@ozzie)
    @sam.adopt(@duece)
    @sam.adopt(@harley)

    @day_care.add_customer(@joel)
    @day_care.add_customer(@sam)

    @day_care.feed_unfed_pets

    assert_equal [], @day_care.unfed_pets
    assert @samson.fed?
    assert @ozzie.fed?
    assert @duece.fed?
    assert @harley.fed?
  end

  def test_charge_to_feed_unfed_pet
    @joel.adopt(@samson)
    @joel.adopt(@ozzie)
    @sam.adopt(@duece)
    @sam.adopt(@harley)

    @day_care.add_customer(@joel)
    @day_care.add_customer(@sam)

    @samson.feed
    @day_care.feed_unfed_pets

    assert_equal 15, @joel.outstanding_balance
    assert_equal 100, @sam.outstanding_balance
  end
end
