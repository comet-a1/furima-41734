class OrdersController < ApplicationController
  before_action :set_item

  def index
    @orders = @item.orders 
  end

  def new
  end

  def create
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order).permit(:quantity, :shipping_address)
  end
end