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
  root to: "public/homes#tp"
  get 'about' => 'public/homes#about'
  
  scope module: 'public' do
    resources :items, only: [:index, :show,]
    get '/mypage' => 'customers#show'
    get '/mypage/edit' => 'customers#edit'
    patch '/mypage' => 'customers#update'
    get 'customers/:id/status' => 'customers#status'
    patch 'customers/:id' => 'customers#change'
    resources :cart_items, only: [:index, :update,:destroy, :create]
    delete 'cart_items' => 'cart_items#destroy_all'
    resources :orders, only: [:new, :create, :show]
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/decision' => 'orders#decision'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
