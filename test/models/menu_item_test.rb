require "test_helper"

class MenuItemTest < ActiveSupport::TestCase
  test "should be invalid without name" do
    menu_item = MenuItem.new(price: 15000, category: "Makanan")
    assert_not menu_item.valid?
    assert_includes menu_item.errors[:name], "can't be blank"
  end

  test "should be invalid without price" do
    menu_item = MenuItem.new(name: "Nasi Goreng", category: "Makanan")
    assert_not menu_item.valid?
    assert_includes menu_item.errors[:price], "can't be blank"
  end

  test "should be invalid without category" do
    menu_item = MenuItem.new(name: "Nasi Goreng", price: 15000)
    assert_not menu_item.valid?
    assert_includes menu_item.errors[:category], "can't be blank"
  end

  test "is_available should be true by default" do
    menu_item = MenuItem.new
    assert menu_item.is_available
  end
end
