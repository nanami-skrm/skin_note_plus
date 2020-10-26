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

  namespace :user do
  	get  'homes/about'=>"homes#about"
  	resources :notes, only: [:index]
  	resources :tweets, only: [:index]
  	resources :items, only: [:index]
  end

  root :to => 'user/homes#top'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
