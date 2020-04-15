require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'

class FoodTruckTest < MiniTest::Test

  def setup
    @food_truck = FoodTruck.new("Rocky Mountain Pies")
  end

  def test_it_exists
    assert_instance_of FoodTruck, @food_truck
  end

  def test_it_has_readable_attributes
    assert_equal "Rocky Mountain Pies", @food_truck.name
  end

  def test_no_inventory_by_default
    assert_equal Hash.new, @food_truck.inventory 
  end
end
