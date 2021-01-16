Rails.application.routes.draw do
  resources :users
  	  namespace :api do
	    namespace :v1 do
	    	resources :users
	    end
	  end
	#Authentication
    post 'auth/signup', to: 'api/v1/users#create'
	post 'auth/signin', to: 'api/v1/users#login'
end
