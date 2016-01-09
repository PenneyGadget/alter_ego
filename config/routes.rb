Rails.application.routes.draw do

 root 'home#index'

 get '/users/new', to: 'users#new'

 post '/teams/find_to_user', to: 'teams#find_to_user'

 get '/teams/find', to: 'teams#find'

 get '/login', to: 'sessions#new'
 post '/login', to: 'sessions#create'
 delete '/logout', to: 'sessions#destroy'

 resources :teams, except: [:index] do
   namespace :admin do
     resources :users, only: [:index]
     resources :teams, only: [:edit]
   end

   resources :admins, only: [:new, :create]
   resources :users
  #    resources :votes, only: [:create]
  #  end
 end

 resources :users, only: [:delete]
 # post '/user_gifs', to: 'sessions#create'

end
