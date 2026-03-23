module Restaurants
  class MenuItemsController < ApplicationController
    before_action :set_restaurant

    # GET /restaurants/:restaurant_id/menu_items
    def index
      @menu_items = @restaurant.menu_items
      @menu_items = @menu_items.where(category: params[:category]) if params[:category].present?
      @menu_items = @menu_items.page(params[:page]).per(params[:per_page] || 10)

      render json: {
        data: @menu_items,
        meta: {
          current_page: @menu_items.current_page,
          next_page: @menu_items.next_page,
          prev_page: @menu_items.prev_page,
          total_pages: @menu_items.total_pages,
          total_count: @menu_items.total_count
        }
      }
    end

    # POST /restaurants/:restaurant_id/menu_items
    def create
      @menu_item = @restaurant.menu_items.create!(menu_item_params)
      render json: @menu_item, status: :created
    end

    private

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def menu_item_params
      params.require(:menu_item).permit(:name, :description, :price, :category, :is_available)
    end
  end
end
