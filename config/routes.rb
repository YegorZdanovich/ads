Ads::Application.routes.draw do

   
  devise_for :users
  
  resources :profiles
  resources :advertisements

  root "home#index"
end
