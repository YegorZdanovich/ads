Ads::Application.routes.draw do

  root "home#index"
   
  devise_for :users
  
  resources :profiles, except: [:index]
  resources :advertisements, except: [:edit, :index]

  get "admin/users", to: "admins#users"
  get "admin/all_ads", to: "admins#all_ads"

  scope '/admin' do
    resources :types, only: [:index, :create, :destroy]
  end
end
