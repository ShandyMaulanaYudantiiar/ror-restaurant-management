require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  test "should be invalid without name" do
    restaurant = Restaurant.new(address: "Jl. Sudirman")
    assert_not restaurant.valid?
    assert_includes restaurant.errors[:name], "can't be blank"
  end

  test "should be invalid without address" do
    restaurant = Restaurant.new(name: "Resto Enak")
    assert_not restaurant.valid?
    assert_includes restaurant.errors[:address], "can't be blank"
  end

  test "should have many menu_items" do
    association = Restaurant.reflect_on_association(:menu_items)
    assert_equal :has_many, association.macro
    assert_equal :destroy, association.options[:dependent]
  end
end
