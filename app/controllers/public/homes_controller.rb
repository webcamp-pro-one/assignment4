class Public::HomesController < ApplicationController
    
    def top
        @items = Item.order(updated_at: :desc)
    end
    
    def about
    end
    
end
