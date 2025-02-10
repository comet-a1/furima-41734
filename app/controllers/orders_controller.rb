class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_invalid_access, only: [:index, :create]

  def index
    @orders = @item.orders
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)

    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      @orders = @item.orders
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_form_params
    params.require(:order_form).permit(:postal_code, :shipping_origin_id, :city, :address_line1,
                                       :address_line2, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def redirect_if_invalid_access
    if @item.user == current_user || @item.sold_out?
      redirect_to root_path
    end
  end
end
