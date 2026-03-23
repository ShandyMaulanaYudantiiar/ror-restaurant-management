require "test_helper"

class MenuItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = Restaurant.create!(name: "Test Resto", address: "Test Address")
    @menu_item = @restaurant.menu_items.create!(name: "Initial Item", price: 1000, category: "Test")
  end

  test "should update menu_item" do
    patch menu_item_url(@menu_item), params: { menu_item: { name: "Updated Name" } }
    assert_response :success
    @menu_item.reload
    assert_equal "Updated Name", @menu_item.name
  end

  test "should destroy menu_item" do
    assert_difference("MenuItem.count", -1) do
      delete menu_item_url(@menu_item)
    end
    assert_response :no_content
  end

  test "should return 404 for non-existent menu_item" do
    get menu_item_url(-1)
    assert_response :not_found
  end

  test "should return 400 for missing menu_item parameter" do
    patch menu_item_url(@menu_item), params: {}
    assert_response :bad_request
  end
end
