class Order < ApplicationRecord
    
    has_many :order_items, dependent: :destroy
    belongs_to :customer
    
    enum payment_option: {クレジットカード:0, 銀行振込:1}
    enum is_active: {入金待ち:0}
    
end
