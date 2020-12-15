Rails.application.routes.draw do

  devise_for :admins,
  controllers: {
  	registrations: 'devise/admins/registrations',
  	sessions: 'devise/admins/sessions'
  }

  devise_for :users,
  controllers: {
  	registrations: 'devise/users/registrations',
  	sessions: 'devise/users/sessions'
  }

  namespace :admin do
    get 'items/top'=>"items#top"
    resources :items do
      resources :reviews, only: [:destroy]
    end
    resources :tweets do
      resources :comments, only: [:destroy]
    end
  end

  namespace :user do
  	get  'homes/about'=>"homes#about"
    post 'homes/guest_sign_in', to: 'homes#new_guest'
    get 'tweets/current_index'=>"tweets#current_index"
    resources :users, only: [:edit, :update]
  	resources :notes, only: [:index, :new, :create]
  	resources :tweets, only: [:index, :create, :destroy, :show] do
      resources :comments, only: [:create, :destroy]
      resource :empathies, only: [:create, :destroy]
    end
    resources :my_items, only: [:index, :create, :edit, :update, :destroy]
  	resources :items, only: [:index, :show]  do
      resources :reviews, only: [:create, :destroy]
    end
  end

  root :to => 'user/homes#top'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
