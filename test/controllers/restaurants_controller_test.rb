require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = Restaurant.create!(name: "Test Resto", address: "Test Address")
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_includes json_response.keys, "data"
    assert_includes json_response.keys, "meta"
  end

  test "should show restaurant with menu_items" do
    @restaurant.menu_items.create!(name: "Item 1", price: 1000, category: "Test")
    get restaurant_url(@restaurant)
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_includes json_response.keys, "menu_items"
    assert_equal 1, json_response["menu_items"].length
  end

  test "should create restaurant" do
    assert_difference("Restaurant.count") do
      post restaurants_url, params: { restaurant: { name: "New Resto", address: "New Address" } }
    end
    assert_response :created
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { name: "Updated Name" } }
    assert_response :success
    @restaurant.reload
    assert_equal "Updated Name", @restaurant.name
  end

  test "should destroy restaurant" do
    assert_difference("Restaurant.count", -1) do
      delete restaurant_url(@restaurant)
    end
    assert_response :no_content
  end

  test "should return 404 for non-existent restaurant" do
    get restaurant_url(-1)
    assert_response :not_found
    json_response = JSON.parse(response.body)
    assert_includes json_response.keys, "error"
  end

  test "should return 422 for invalid creation" do
    post restaurants_url, params: { restaurant: { name: "" } }
    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_includes json_response.keys, "errors"
  end
  test "should return 400 for missing parameter" do
    post restaurants_url, params: {}
    assert_response :bad_request
    json_response = JSON.parse(response.body)
    assert_includes json_response.keys, "error"
  end
end
