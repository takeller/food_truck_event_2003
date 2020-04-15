require 'minitest/autorun'
require 'minitest/pride'
require './lib/food_truck'
require './lib/item'
require './lib/event'

class EventTest < MiniTest::Test

  def setup
    @event = Event.new("South Pearl Street Farmers Market")
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
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

  def test_add_food_truck
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expected = [@food_truck1, @food_truck2, @food_truck3]
    assert_equal expected, @event.food_trucks
  end

  def test_food_truck_names
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expected = ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"]
    assert_equal expected, @event.food_truck_names
  end

  def test_food_trucks_that_sell
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expected = [@food_truck1, @food_truck3]
    assert_equal expected, @event.food_trucks_that_sell(@item1)

    expected = [@food_truck2]
    assert_equal expected, @event.food_trucks_that_sell(@item4)
  end

  def test_items_in_event
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expected = {
      @item1 => {},
      @item2 => {},
      @item3 => {},
      @item4 => {}
    }
    assert_equal expected, @event.items_in_event
  end

  def test_total_quantity
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    assert_equal 100, @event.total_quantity(@item1)
  end

  def test_total_inventory
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expected =  {
      @item1 => {
        quantity: 100,
        food_trucks: [@food_truck1, @food_truck3]
      },
      @item2 => {
        quantity: 7,
        food_trucks: [@food_truck1]
      },
      @item3 => {
        quantity: 35,
        food_trucks: [@food_truck2, @food_truck3]
      },
      @item4 => {
        quantity: 50,
        food_trucks: [@food_truck2]
      }
    }

    assert_equal expected, @event.total_inventory
  end

  def test_sorted_item_list
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expected = ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"]

    assert_equal expected, @event.sorted_item_list
  end

end
