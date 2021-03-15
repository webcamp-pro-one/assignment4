class Public::CartItemsController < ApplicationController
    
    def index
        @cart_items = CartItem.all
        @tax = 1.1
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
    
end
