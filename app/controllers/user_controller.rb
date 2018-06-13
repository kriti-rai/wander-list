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
    #redirects to their board view
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.save

    if !!@user.save
      session[:id] = @user.id
      redirect to "/"
    elsif !!params[:username].empty? || !!params[:email].empty? || !!params[:password].empty?
      flash[:message] = "All fields are required."
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
    #shows to their board view
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
    #shows the list of all users
    @users = User.all
    erb :'users/index'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end
