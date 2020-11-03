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
    resources :items
  end

  namespace :user do
  	get  'homes/about'=>"homes#about"
  	resources :notes, only: [:index, :new, :create]
  	resources :tweets, only: [:index, :create, :destroy, :show]
    resources :my_items, only: [:index, :create, :edit, :update, :destroy]
  	resources :items, only: [:index, :show]  do
      resources :reviews, only: [:create, :destroy]
    end
  end

  root :to => 'user/homes#top'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
