Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'toppages#index'
	
	#ログイン情報を保存するためのアクション
	get 'login' => 'sessions#new'
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'
	
	get 'signup' => 'users#new'
	resources :users, only: [:index, :show, :new, :create] do
		member do
			get :followings
			get :followers
		end
	end
	
	resources :microposts, only: [:create, :destroy]
	resources :relationships, only: [:create, :destroy]
end
