require "test_helper"

class MenuItemApiTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = Restaurant.create!(name: "Toko Sate", address: "Jl. Sudirman")
    @menu_item = @restaurant.menu_items.create!(name: "Sate Ayam", price: 25000, category: "main")
  end

  test "GET /restaurants/:id/menu_items returns 200 OK" do
    get restaurant_menu_items_url(@restaurant)
    assert_response :success
  end

  test "GET /restaurants/:id/menu_items with category filter returns 200 OK" do
    get restaurant_menu_items_url(@restaurant), params: { category: "main" }
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "main", json_response["data"].first["category"]
  end

  test "POST /restaurants/:id/menu_items with valid data returns 201 Created" do
    assert_difference "MenuItem.count", 1 do
      post restaurant_menu_items_url(@restaurant), params: {
        menu_item: { name: "Es Teh", price: 5000, category: "drink" }
      }
    end
    assert_response :created
  end

  test "POST /restaurants/:id/menu_items with invalid data returns 422 Unprocessable Entity" do
    post restaurant_menu_items_url(@restaurant), params: {
      menu_item: { name: "", price: 5000, category: "drink" }
    }
    assert_response :unprocessable_entity
  end

  test "PATCH /menu_items/:id returns 200 OK" do
    patch menu_item_url(@menu_item), params: { menu_item: { name: "Sate Kambing" } }
    assert_response :success
  end

  test "DELETE /menu_items/:id returns 204 No Content" do
    assert_difference "MenuItem.count", -1 do
      delete menu_item_url(@menu_item)
    end
    assert_response :no_content
  end
end
