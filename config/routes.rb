Rails.application.routes.draw do
 get "/home/about" => "homes#about"
 devise_for :users
 # get 'users/edit'
  #get 'users/index'
  #get 'users/show'
  #get 'books/edit'
  #get 'books/index'
  #get 'books/show'
   resources :users, only: [:index, :show, :edit, :update]
   resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resources :book_comments, only:[:create,:destroy]
    #いいねはURL にidを含めなくて良いためresorce
     resource :favorites, only: [:create, :destroy]
   end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

   root to: 'homes#top'

end
