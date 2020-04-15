require 'pry'
class FoodTruck

  attr_reader :name, :inventory
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quantity)
    @inventory[item] += quantity
  end

  def potential_revenue
    potential_revenue = 0
    @inventory.each do |item, quantity|
      potential_revenue += item.price.delete("$").to_f * quantity
    end
    potential_revenue
  end
end


# A FoodTruck will be able to calculate their potential_revenue - the sum of all their items' price * quantity.
#
# A Event is responsible for keeping track of FoodTrucks. It should have a method called food_truck_names that returns an array of all the FoodTruck's names.
#
# Additionally, the Event should have a method called food_trucks_that_sell that takes an argument of an item represented as a String. It will return a list of FoodTrucks that have that item in stock.
#
# Use TDD to create a Event class that responds to the following interaction pattern:
