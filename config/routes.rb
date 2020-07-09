Rails.application.routes.draw do
  resources :categories
  resources :articles ,except: [:destroy]
  root to: 'home#home'
  resources :users, except: [:new,:show,:destroy]
  get '/comments', to: 'articles#comment'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  delete '/logout', to: 'sessions#destroy'
  post '/login', to: 'sessions#create'
  get 'my_comments', to: 'comments#my_comments'
  get 'like/:id', to: 'articles#like'  , as: 'like_inc'
  get 'dislike/:id', to: 'articles#dislike'  , as: 'dislikelike_inc'
  get 'search_category', to: 'articles#category_search'
  get 'my_liked/', to: 'articles#my_liked'  , as: 'my_liked'

end
