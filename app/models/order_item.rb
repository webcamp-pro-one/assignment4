class OrderItem < ApplicationRecord
    
    belongs_to :order
    belongs_to :item
    
    enum is_active: {製作待ち:0}
    
end
