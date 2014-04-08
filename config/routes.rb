Ads::Application.routes.draw do

   
  devise_for :users
  
  resources :profiles

  root "home#index"
end
