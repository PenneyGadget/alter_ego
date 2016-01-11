Rails.application.routes.draw do

 root 'home#index'

 get '/users/new', to: 'users#new'
 patch '/declare_winner', to: 'users#update_user_gif'

 post '/teams/find_to_user', to: 'teams#find_to_user'

 get '/teams/find', to: 'teams#find'

 get '/login', to: 'sessions#new'
 post '/login', to: 'sessions#create'
 delete '/logout', to: 'sessions#destroy'

 resources :teams, except: [:index] do

   resources :admins, only: [:new, :create]

   namespace :admin do
     resources :users, only: [:index, :destroy]
     resources :teams, only: [:edit]
     resources :auctions
   end

   resources :users do
     patch '/declare_winner', to: 'users#update_user_gif'
   end

   resources :auctions, only: [:show, :new] do
     patch '/update_votes', to: 'auctions#update_votes'
   end

 end

 # resources :users, only: [:delete]
 # post '/user_gifs', to: 'sessions#create'
end
