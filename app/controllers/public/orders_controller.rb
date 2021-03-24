class Public::OrdersController < ApplicationController

    before_action :set_tax, only: [:new, :confirm, :create]
    before_action :set_customer, only: [:create]
    before_action :set_shipping, only: [:new, :confirm, :show]
    
    def new 
         @order = current_customer.order.new
         @cart_items = current_customer.cart_items
         @customer = current_customer
         @addresses = current_customer.addresses.all
    end
    
    def confirm
        @order = current_customer.order.new(order_params)
        @customer = current_customer
        @cart_items = current_customer.cart_items
        
        if params[:order][:payment] == "0"
            @order.payment_option = 0
        elsif params[:order][:payment] == "1"
            @order.payment_option = 1
        end
        
        if params[:order][:address_option] == "0"
            @order.delivery_postal_code = @customer.postal_code
            @order.delivery_address = @customer.address
            @order.delivery_name = @customer.last_name+@customer.first_name
            
        elsif params[:order][:address_option] == "1"
            @a_id = params[:order][:order_address].to_i
            @order_address = Address.find(@a_id)
            @order.delivery_postal_code = @order_address.postal_code
            @order.delivery_address = @order_address.address
            @order.delivery_name = @order_address.name
            
        elsif params[:order][:address_option] == "2"
            @order.delivery_postal_code = params[:order][:delivery_postal_code]
            @order.delivery_address = params[:order][:delivery_address]
            @order.delivery_name = params[:order][:delivery_name]
        end
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
        @orders = Order.page(params[:page]).per(3).reverse_order
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
                                      :created_at,
                                      :updated_at,
                                      :customer_id)
    end
    
    def order_item_params
        params.require(:order_item).permit(:price_intax, 
                                           :amount,
                                           :is_active,
                                           :created_at,
                                           :updated_at,
                                           :item_id,
                                           :order_id)
    end
        
    
    def cart_item_params
        params.require(:cart_item).permit(:customer_id, :item_id, :amount)
    end
    
end
