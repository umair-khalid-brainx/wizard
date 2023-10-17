Rails.application.routes.draw do
  devise_for :users
  resources :profiles
  post '/profiles/upload_file', to: 'profiles#upload_file'
  root to: "home#index"
end
