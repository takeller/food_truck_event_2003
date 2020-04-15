require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < MiniTest::Test

  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists
    assert_instance_of Item, @item1
    assert_instance_of Item, @item2
  end

  def test_it_has_readable_attributes
    assert_equal 'Peach Pie (Slice)', @item1.name
    assert_equal 'Apple Pie (Slice)', @item2.name
    assert_equal "$3.75", @item1.price
    assert_equal '$2.50', @item2.price
  end
end
