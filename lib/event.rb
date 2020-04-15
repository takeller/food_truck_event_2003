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
      food_truck.inventory.has_key?(item)
    end 
  end
end
