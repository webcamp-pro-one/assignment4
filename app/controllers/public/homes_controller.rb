class Public::HomesController < ApplicationController
    
    def top
        @items = Item.order(updated_at: :desc).limit(4)
    end
    
    def about
    end
    
end
