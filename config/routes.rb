Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_scope :user do
    get '/user_registration/:token' => 'registrations#new', :as => :new_user_registration
    post '/signup' => 'registrations#create', :as => :user_registration
    post '/signin' => 'sessions#create', :as => :user_session
    get '/login' =>  'sessions#new', :as => :new_user_session
  end

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }, skip: [:sessions]
  
  resources :instituicaos, only: [:new, :create]

  devise_for :usuario_nextis
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match 'welcome' => 'welcome#index', via: [:get]
  match 'not_actived' => 'user_not_active#index', via: [:get], :as => :user_not_actived

  root "welcome#index"
  
end
