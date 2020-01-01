require 'minitest/autorun'
require 'minitest/pride'
require './lib/pet'

class PetTest < Minitest::Test

  def setup
    @samson = Pet.new({name: "Samson", type: :dog})
  end

  def test_it_exists
    assert_instance_of Pet, @samson
  end

  def test_it_has_attributes
    assert_equal "Samson", @samson.name
    assert_equal :dog, @samson.type
    refute @samson.fed?
    refute @samson.hair_cut
    refute @samson.washed
    refute @samson.nails_trimmed
  end

  def test_can_be_fed
    refute @samson.fed?

    @samson.feed

    assert @samson.fed?
  end
end
