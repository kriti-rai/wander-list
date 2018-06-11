class UserController < ApplicationController

  get '/signup' do
    #directs user to the signup form
    erb :'users/signup'
  end

  post '/signup' do
    #gets params and creates a user
    #logs the user in
    #redirects to their board view
    @user = User.new(params)

    if !params[:username].empty? && !params[:email].empty? && params[:password].empty?
      @user.save
      session[:id] = user.id
      #redirect to "/users/#{@user.slug}"
    else
      '/signup'
    end

  end

  get '/login' do
    #directs user to the login form
    erb :'users/login'
  end

  post '/login' do
    #gets params and logs the user in
    #shows to their board view
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = user.id
      #redirect to "/users/#{@user.slug}"
    else
      redirect to '/login'
    end

  end

  get '/logout' do
    #clears session
    #redirect to '/'
    session.clear
    #redirect to "/users/#{@user.slug}"
  end


  # ---------------users page------------

  get '/users' do
    #shows the list of all users
    @users = User.all
    erb :'users/index'
  end

  get '/users/:slug' do
    #finds and shows an individual user
    @user = User.find_by(params[:slug])
    erb :'users/show'
  end




end
