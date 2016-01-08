Rails.application.routes.draw do

 root 'home#index'

 get '/users/new', to: 'users#new'

 post '/teams/find_to_user', to: 'teams#find_to_user'

 get '/teams/find', to: 'teams#find'

 get '/login', to: 'sessions#new'
 post '/login', to: 'sessions#create'
 delete '/logout', to: 'sessions#destroy'

 resources :teams, except: [:index] do
   resources :admins, only: [:new, :create] do
     resources :users, only: [:destroy, :index]
   end

   resources :users
  #    resources :votes, only: [:create]
  #  end
 end
 # post '/user_gifs', to: 'sessions#create'

end
