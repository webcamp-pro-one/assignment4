class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    
    
    

    protected
    
    def set_customer
        @id = current_customer.id
    end
    
    def set_shipping
        @shipping = 800
    end
    
    def set_tax
        @tax = 1.1
    end
    
    def configure_permitted_parameters
        if resource_class == Customer
            devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,
                                                               :first_name,
                                                               :last_name_kana,
                                                               :first_name_kana,
                                                               :telephone_number,
                                                               :postal_code,
                                                               :address,
                                                               :is_activ])
            devise_parameter_sanitizer.permit(:sign_in,keys: [:email])
            devise_parameter_sanitizer.permit(:account_update,keys: [:last_name,
                                                                    :first_name,
                                                                    :last_name_kana,
                                                                    :first_name_kana,
                                                                    :telephone_number,
                                                                    :postal_code,
                                                                    :address,
                                                                    :is_active])
        elsif resource_class == Admin
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
            devise_parameter_sanitizer.permit(:sign_in,keys: [:email])
            devise_parameter_sanitizer.permit(:account_update,keys: [:name,:email])
        end
    end
    
    private
    
    def after_sign_up_path_for(resource)
        mypage_path(resource)
    end
    
    def after_sign_in_path_for(resource)
        case resource
            when Admin
              admin_top_path          
            when Customer
              root_path              
        end
    end
    
    def after_sign_out_path_for(resource_or_scope)
        if resource_or_scope == :admin
            new_admin_session_path
        else
            new_customer_session_path
        end
    end
  
end
