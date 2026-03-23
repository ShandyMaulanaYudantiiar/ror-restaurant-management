require "test_helper"

class Restaurants::MenuItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = Restaurant.create!(name: "Test Resto", address: "Test Address")
  end

  test "should get index for restaurant" do
    @restaurant.menu_items.create!(name: "Item 1", price: 1000, category: "Test")
    get restaurant_menu_items_url(@restaurant)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response["data"].length
    assert_includes json_response.keys, "meta"
  end

  test "should filter index by category" do
    @restaurant.menu_items.create!(name: "Item 1", price: 1000, category: "Main")
    @restaurant.menu_items.create!(name: "Item 2", price: 500, category: "Drink")
    get restaurant_menu_items_url(@restaurant), params: { category: "Main" }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal 1, json_response["data"].length
    assert_equal "Main", json_response["data"][0]["category"]
  end

  test "should create menu_item for restaurant" do
    assert_difference("MenuItem.count") do
      post restaurant_menu_items_url(@restaurant), params: {
        menu_item: { name: "New Item", price: 5000, category: "Side" }
      }
    end
    assert_response :created
  end

  test "should return 422 for invalid menu_item creation" do
    post restaurant_menu_items_url(@restaurant), params: {
      menu_item: { name: "" }
    }
    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_includes json_response.keys, "errors"
  end
end
