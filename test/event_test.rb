require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'
require './lib/event'

class EventTest < MiniTest::Test

  def setup
    @event = Event.new("South Pearl Street Farmers Market")
  end

  def test_it_exists
    assert_instance_of Event, @event
  end

  def test_it_has_a_name
    assert_equal "South Pearl Street Farmers Market", @event.name
  end

  def test_it_has_no_food_trucks_by_default
    assert_equal Array.new, @event.food_trucks
  end
end
