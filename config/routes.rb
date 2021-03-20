Rails.application.routes.draw do
  
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
    registrations: 'admin/registrations'
  }
  
  devise_for :customers, controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
  
  namespace :admin do
    get '/top' => 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genre, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show]
  end
  
  
  get '/' => 'public/homes#top'
  root to: "public/homes#top"
  get 'about' => 'public/homes#about'
  
  scope module: 'public' do
    resources :items, only: [:index, :show,]
    get '/mypage' => 'customers#show'
    get '/mypage/edit' => 'customers#edit'
    patch '/mypage/edit' => 'customers#update'
    get 'customers//status' => 'customers#status', as: 'customer_status'
    patch 'customers/change' => 'customers#change', as: 'change_status'
    resources :cart_items, only: [:index, :update, :create]
    delete 'cart_item/:id' => 'cart_items#destroy', as: 'destroy_cart_item'
    delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_cart_items'
    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/decision' => 'orders#decision'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
