class Public::CartItemsController < ApplicationController
    
    before_action :set_tax, only: [:index]
    
    def index
        @cart_items = CartItem.all
        @order = Order.new
        @order_item = @order.order_items.new
    end
    
    def create
        @cart_item = CartItem.new(cart_item_params)
        @cart_item.save(cart_item_params)
        redirect_to cart_items_path
    end
    
    def destroy
        @cart_item = CartItem.find(params[:id])
        @cart_item.destroy
        redirect_to cart_items_path
    end
    
    def destroy_all
        id = current_customer.id
        CartItem.where(customer_id: id).destroy_all
        redirect_to cart_items_path
    end
    
    private
    
    def cart_item_params
        params.require(:cart_item).permit(:customer_id, :item_id, :amount)
    end
    
    def order_item_params
        params.require(:order_item).permit(:price_intax, 
                                           :amount,
                                           :is_active,
                                           :create_at,
                                           :update_at,
                                           :item_id,
                                           :order_id)
    end
    
    
end
