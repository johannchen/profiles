Profiles::Application.routes.draw do
  root :to => 'homes#show'

  devise_for :users,
    :controllers => {:omniauth_callbacks => 'sessions'}

  get '/users/auth/:provider' => 'sessions#passthru'

  match 'profile' => 'profiles#show', :as => :my_profile
  resources :profiles do
    resource :theme
  end


  resource :search
  resource :home
end
