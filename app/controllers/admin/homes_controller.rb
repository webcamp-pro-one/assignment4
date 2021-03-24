class Admin::HomesController < ApplicationController
    
    def top
        @orders = Order.page(params[:page]).per(6).reverse_order
    end
    
end
