class Admin::CustomersController < ApplicationController
    
    def show
        @customer = Customer.find(params[:id])
    end
    
    def edit
        @customer = Customer.find(params[:id])
    end
    
    def update
        @customer = Customer.find(params[:id])
        @customer.update(customer_params)
        redirect_to admin_customer_path(@customer.id)
      
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
