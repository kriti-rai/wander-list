require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash, :sweep => true

  get '/signup' do
    #directs user to the signup form
    if Helper.logged_in?(session)
      redirect to '/'
     else
       erb :'users/signup'
     end
  end

  post '/signup' do
    #gets params and creates a user
    #logs the user in
    #redirects to homepage for logged in users
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save

    if !!@user.save
      session[:id] = @user.id
      redirect to "/"
    elsif !!params[:username].empty? || !!params[:email].empty? || !!params[:password].empty?
      flash[:message] = @user.errors.full_messages[0]
      redirect to '/signup'
    else
      flash[:message] = @user.errors.full_messages[0]
      redirect to '/signup'
    end

  end

  get '/login' do
    #directs user to the login form
    if Helper.logged_in?(session)
      redirect to '/'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    #gets params and logs the user in
    #shows to homepage for logged in users
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect to "/"
    else
      redirect to '/login'
    end

  end

  get '/logout' do
    session.clear
    redirect to "/"
  end

  # ---------------users page------------

  get '/users' do
    #shows the list of all users and their board
    if !Helper.logged_in?(session)
      flash[:message] = "You must be logged in to perform this action."
      redirect to '/'
    else
      @users = User.all
      erb :'users/index'
    end
  end

  get '/users/:slug' do
    #finds and shows users by slug
    @user = User.find_by_slug(params[:slug])
    @current_user = Helper.current_user(session)
    erb :'users/show'
  end

end
