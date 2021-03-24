class Public::AddressesController < ApplicationController
    
    def index
        @addresses = current_customer.addresses.page(params[:page]).per(2).reverse_order
        @address = current_customer.addresses.new
    end
    
    def create
        @address = current_customer.addresses.new(address_arams)
        @address.save(address_arams)
        redirect_to addresses_path
    end
    
    def edit
        @address = Address.find(params[:id])
    end
    
    def update
        @address = Address.find(params[:id])
        @address.update(address_arams)
        redirect_to addresses_path
    end
    
    def destroy
        @address = Address.find(params[:id])
        @address.destroy
        redirect_to addresses_path
    end
    
    private
    
    def address_arams
        params.require(:address).permit(:name,
                                        :postal_code,
                                        :address,
                                        :create_at,
                                        :update_at,
                                        :customer_id)
    end

end
