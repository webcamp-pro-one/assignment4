class Item < ApplicationRecord
    
    has_many :cart_items, dependent: :destroy
    has_many :order_items, dependent: :destroy
    
    attachment :image
    
    enum is_active: {販売中:0, 販売停止:1, 売切れ:2}
    
end
