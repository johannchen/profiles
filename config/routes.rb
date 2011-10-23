Profiles::Application.routes.draw do
  root :to => 'homes#show'

  devise_for :users,
    :controllers => {:omniauth_callbacks => 'sessions',
                     :registrations      => 'users'} rescue nil

  get '/users/auth/:provider' => 'sessions#passthru'

  match 'profile' => 'profiles#show', :as => :my_profile
  resources :profiles do
    resources :alerts
    resource :theme
  end

  resource :search
  resource :home

  namespace :admin do
    resource :dashboard
    resources :users
  end
end
