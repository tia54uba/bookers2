Rails.application.routes.draw do
    devise_for :users
  root to:'homes#top'
  get 'home/about'=>'homes#about' ,as: 'about'

  resources :books, only: [:index,:show,:edit,:create,:update,:destroy]
  #get 'books/index'
  #get 'books/show'
  #get 'books/edit'

  resources :users, only: [:index,:show,:edit,:update]
  #get 'users/index'
  #get 'users/show'
  #get 'users/edit'

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
