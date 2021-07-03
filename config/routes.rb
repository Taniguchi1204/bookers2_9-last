Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only:[:create,:destroy,:followings,:followers]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :books do
    resource :favorites, only:[:create,:destroy]
  resources :book_comments, only:[:create,:destroy]
  end

  get "search" => "books#search", as: "search"
  get "rate" => "books#rate", as: "rate"

  resources :groups, only:[:show,:index,:new,:create,:edit,:update] do
    resource :group_users, only:[:create,:destroy]
  end
  resources :chats, only:[:show,:create]

  get "search" => "searchs#search", as: "search_page"
end