require 'pry'
class Event

  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = Array.new
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    food_trucks = @food_trucks.map { |food_truck| food_truck.name }
  end

  def food_trucks_that_sell(item)
    food_trucks_with_item = @food_trucks.find_all do |food_truck|
      food_truck.check_stock(item) > 0
    end
  end

  def items_in_event
    event_items = Hash.new
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, quantity|
        event_items[item] = {}
      end
    end
    event_items
  end

  def total_quantity(item)
    total_quantity = 0
    @food_trucks.each do |food_truck|
      total_quantity += food_truck.check_stock(item)
    end
    total_quantity
  end

  def total_inventory
    total_inventory = items_in_event
    total_inventory.map do |item, item_info|
      item_info[:quantity] = total_quantity(item)
      item_info[:food_trucks] = food_trucks_that_sell(item)
    end
    total_inventory.to_h
  end

  def sorted_item_list
    item_list = items_in_event.keys
    named_item_list = item_list.map { |item| item.name  }
    sorted_list = named_item_list.sort
  end


end


# Add a method to your Event class called sorted_item_list that returns a list of names of all items the FoodTrucks have in stock, sorted alphabetically. This list should not include any duplicate items.
#
# Additionally, your Event class should have a method called total_inventory that reports the quantities of all items sold at the event. Specifically, it should return a hash with items as keys and hash as values - this sub-hash should have two key/value pairs: quantity pointing to total inventory for that item and food_trucks pointing to an array of the food trucks that sell that item.
#
# You Event will also be able to identify overstocked_items. An item is overstocked if it is sold by more than 1 food truck AND the total quantity is greater than 50.
#
# Use TDD to update your Event class so that it responds to the following interaction pattern:
