Kickerapp::Application.routes.draw do
  root :to => 'pages#landing'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'ligen' => "leagues#index", as: 'ligen'

  get 'pebble_settings' => 'pages#pebble_settings'

  resources :leagues, except: [:index], :path => '' do
    get :badges, on: :member
    resources :matches do
      post :shuffle, on: :collection
      get :shuffle_select, on: :collection
    end
    resources :users
    resources :teams, only: [:index, :show]
  end


  resources :matches, only: [:show]
  get "/auth/:provider/callback" => "users#create"

end
