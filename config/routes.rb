Rails.application.routes.draw do
  get 'user_prefs/interests'
  post 'user_prefs/update_interest'

  resources :tags
  resources :levels

  get '/roadmap', to: 'levels#roadmap'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/highscore', to: 'application#highscore'

  resources :categories
  resources :missions
  resources :accepted_missions
  resources :messages
  resources :newsitems do
    member do
      put "upvote"#, to: "newsitems#upvote"
      put "downvote"#, to: "newsitems#downvote"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to: "missions#index"
  root to: "messages#index"
end
