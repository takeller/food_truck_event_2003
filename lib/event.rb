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

  def overstocked_items
    overstocked_items = []
    total_inventory.each do |item, item_info|
      if item_info[:quantity] > 50 && item_info[:food_trucks].length > 1
        overstocked_items << item
      end
    end
    overstocked_items
  end

  def sell(item, quantity)
    # Check for enough item quantity
    quantity_remaining = 0
    return false if total_quantity(item) < quantity
    food_trucks_that_sell(item).each do |food_truck|
      if food_truck.inventory[item] >= quantity
        food_truck.inventory[item] - quantity
      elsif quantity_remaining != 0 && food_truck.inventory[item] >= quantity_remaining
        food_truck.inventory[item] - quantity_remaining
      else 
        quantity_remaining = quantity - food_truck.inventory[item]
        food_truck.inventory[item] = 0
      end

    end
    true

  end

end
