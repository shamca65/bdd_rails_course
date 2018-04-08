Rails.application.routes.draw do
  root 'articles#new'
  resources :articles
end
