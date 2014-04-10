Ads::Application.routes.draw do

   
  devise_for :users
  
  resources :profiles
  resources :advertisements

  get "admins/users"
  get "admins/all_ads"

  root "home#index"
end
