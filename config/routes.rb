Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :posts
  resources :conversations do 
    resources :messages
  end
end
