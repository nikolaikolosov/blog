Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root to: "posts#index"
  get 'tags/:tag', to: 'posts#index', as: "tag"

  resources :posts do
    resources :comments
  end
end
