Ads::Application.routes.draw do

  root "advertisements#index"

  devise_for :users

  resources :profiles, except: [:index]
  resources :advertisements, except: [:edit]

  get "admin/users", to: "admins#users"
  get "admin/all_ads", to: "admins#all_ads"

  scope '/admin' do
    resources :categories, only: [:index, :create, :destroy]
  end
end
