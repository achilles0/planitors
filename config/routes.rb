Rails.application.routes.draw do
  resources :levels

  get '/roadmap', to: 'levels#roadmap'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/highscore', to: 'application#highscore'

  resources :categories
  resources :missions
  resources :accepted_missions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "missions#index"
end
