class Public::OrdersController < ApplicationController

    before_action :set_tax, only: [:new, :confirm, :create]
    before_action :set_customer, only: [:create]
    before_action :set_shipping, only: [:new, :confirm, :show]
    
    def new 
         @order = current_customer.order.new
         @cart_items = current_customer.cart_items
    end
    
    def confirm
        @order = current_customer.order.new(order_params)
        @cart_items = current_customer.cart_items
    end
    
    def create
        
        @order = current_customer.order.new(order_params)
        @order.save
        @cart_items = current_customer.cart_items
        @cart_items.each do |cart_item|
            @order_items = @order.order_items.new
            @order_items.item_id = cart_item.item_id
            @order_items.price_intax = (cart_item.item.price*@tax).floor
            @order_items.amount = cart_item.amount
            @order_items.save
        end
        @cart_items.destroy_all
        render :decision
        # カートアイテムのしょうひんを保存す
    end
    
    def decision
        @order = Order.find(params[:id])
        @order_items = OrderItem.all
    end
    
    def index
        @orders = Order.all
    end
    
    def show
        @order = Order.find(params[:id])
        @order_item = @order.order_items.all
    end


    private
    
    def order_params
        params.require(:order).permit(:delivery_postal_code,
                                      :delivery_address,
                                      :delivery_name,
                                      :shipping,
                                      :billing_amount,
                                      :payment_option,
                                      :is_active,
                                      :create_at,
                                      :update_at,
                                      :customer_id)
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
        
    
    def cart_item_params
        params.require(:cart_item).permit(:customer_id, :item_id, :amount)
    end
    
end
