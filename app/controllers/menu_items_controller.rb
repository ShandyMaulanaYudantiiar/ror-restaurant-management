class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [ :update, :destroy ]

  # PATCH/PUT /menu_items/1
  def update
    @menu_item.update!(menu_item_params)
    render json: @menu_item
  end

  # DELETE /menu_items/1
  def destroy
    @menu_item.destroy!
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :description, :price, :category, :is_available)
  end
end
