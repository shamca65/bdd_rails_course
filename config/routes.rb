Rails.application.routes.draw do
  devise_for :users do
    get 'login', to: 'devise/sessions#new'
  end
  
  root 'articles#index'
  
  resources :articles do
    resources :comments
  end
end
