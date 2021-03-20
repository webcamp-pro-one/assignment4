class Public::CustomersController < ApplicationController
    
    before_action :set_customer, only: [:change]
    
    def show
        @customer = Customer.find(current_customer.id)
    end
    
    def edit
        @customer = Customer.find(current_customer.id)
    end
    
    def update
        @customer = Customer.new(params[:id])
        @customer.update(customer_params)
        redirect_to mypage_path
    end
    
    def status
        @customer = Customer.find(current_customer.id)
    end
    
    def change
        @customer = Customer.new(id: @id)
        @customer.update(is_active: "false")
        reset_session
        redirect_to root_path
    end
            
    
     private
    
    def customer_params
        params.require(:customer).permit(:last_name,
                                         :first_name,
                                         :last_name_kana,
                                         :first_name_kana,
                                         :email,
                                         :telephone_number,
                                         :postal_code,
                                         :address,
                                         :is_active)
    end
    
end
