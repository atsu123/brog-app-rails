Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'posts#index' #トップページ
  delete 'posts/:id' => 'posts#destroy'
  resources :posts, only: [:create, :new, :edit, :update, :destroy, :show]
end
