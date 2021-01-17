Rails.application.routes.draw do
  mount Raddocs::App => "/docs"
  resources :transactions
  resources :wallets
  resources :currencies
  resources :users
  	  namespace :api do
	    namespace :v1 do
	    	resources :users
	    	resources :transactions
  			resources :wallets
  			resources :currencies
	    end
	  end
	#Authentication
    post 'auth/signup', to: 'api/v1/users#create'
	post 'auth/signin', to: 'api/v1/users#login'
end
