class Admin::ItemsController < ApplicationController
    
    def index
        @items = Item.page(params[:page]).per(10).reverse_order
    end

    def new
        @item = Item.new
    end
    
    def create
        @item = Item.new(item_params)
        @item.save
        redirect_to admin_item_path(@item)
    end
    
    def show
        @item = Item.find(params[:id])
    end
    
    def edit
        @item = Item.find(params[:id])
    end
    
    def update
        @item = Item.find(params[:id])
        if params[:item][:active_option] == "0"
            @item.is_active = 0
        elsif params[:item][:active_option] == "1"
            @item.is_active = 1
        elsif params[:item][:active_option] == "2"
            @item.is_active = 2
        end
        @item.update(item_params)
        redirect_to admin_item_path(@item.id)
    end
    
    private
    
    def item_params
        params.require(:item).permit(:name, :introduction, :image, :price, :is_active)
    end
    
end
