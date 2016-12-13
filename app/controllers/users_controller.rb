class UsersController < ApplicationController

	get '/signup' do
		if logged_in?
			redirect "/users/#{current_user.id}"
		else
			erb :'users/new_user'
		end
		
	end

	post '/users' do
		user = User.create(username: params[:username], password: params[:password])
		session[:user_id] = user.id
		flash[:message] = "Account Created"
		redirect to "/users/#{current_user.id}"
	end


	get '/login' do
		if logged_in?
			flash[:message] = "Already logged in"
			redirect "/users/#{current_user.id}"
		else
			flash[:message] = "Must be logged in"
			erb :'users/login'
		end
	end

	post '/login' do 
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to "/users/#{current_user.id}"
		else
			redirect '/signup'
		end

	end

	get '/logout' do 
		if logged_in?
			session.clear
			flash[:message] = "Bye bye!" 
			redirect '/'
		else
			redirect '/'
		end
		
	end

	get	'/users/:id' do
	 if logged_in? 
	 	erb :'users/show'
	 else
	 	redirect '/login'
	 end
	end


end