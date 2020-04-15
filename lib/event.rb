class Event

  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = Array.new
  end
end
