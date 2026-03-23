class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [ :show, :update, :destroy ]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all.page(params[:page]).per(params[:per_page] || 10)
    render json: {
      data: @restaurants,
      meta: {
        current_page: @restaurants.current_page,
        next_page: @restaurants.next_page,
        prev_page: @restaurants.prev_page,
        total_pages: @restaurants.total_pages,
        total_count: @restaurants.total_count
      }
    }
  end

  # GET /restaurants/1
  def show
    render json: @restaurant.as_json(include: :menu_items)
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.create!(restaurant_params)
    render json: @restaurant, status: :created
  end

  # PATCH/PUT /restaurants/1
  def update
    @restaurant.update!(restaurant_params)
    render json: @restaurant
  end

  # DELETE /restaurants/1
  def destroy
    @restaurant.destroy!
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone, :opening_hours)
  end
end
