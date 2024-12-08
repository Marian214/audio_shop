Rails.application.routes.draw do
  root "home#index"
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'contacts', to: 'home#contacts'
  post 'create_feedback', to: 'home#create_feedback'

  resources :products do
    resources :comments, only: [:create]
  end

  resource :cart, only: [:show] do
    post 'add/:product_id', to: 'carts#add', as: :add
    delete 'remove/:id', to: 'carts#remove', as: :remove
    delete 'clear', to: 'carts#clear', as: :clear
    get 'checkout', to: 'carts#checkout', as: :checkout
  end

  resources :orders, only: [:new, :create, :show]

  resources :cart_items, only: [:create] do
    member do
      post :increase_quantity
      post :decrease_quantity
    end
  end
end
