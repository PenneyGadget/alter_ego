Rails.application.routes.draw do

 # get '/login', to: 'sessions#new'
 # post '/login', to: 'sessions#create'

 resources :teams, except: [:index] do
  #  namespace :admin do
  #    resources :users, only: [:destroy, :index]
  #  end

   resources :users 
  #    resources :votes, only: [:create]
  #  end
 end
 # post '/user_gifs', to: 'sessions#create'

end
