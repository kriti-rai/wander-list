require 'rack-flash'

class BoardController < ApplicationController
  use Rack::Flash, :sweep => true

  #---------CREATE -----------
  get '/boards/new' do
    if !Helper.logged_in?(session)
      flash[:message]="You have to be logged in to perform that action."
     redirect to '/'
   else
     erb :'boards/new'
   end
  end

  post '/boards' do
    @user = Helper.current_user(session)
    if !!params[:name].empty?
      redirect to '/boards/new'
    else
      @board = @user.boards.create(name: params[:name])
      @user.save
      redirect to "/boards/#{@board.id}"
    end
  end

  #------------EDIT--------------
  get '/boards/:id/edit' do
    if !Helper.logged_in?(session)
      flash[:message]="You have to be logged in to perform that action."
      redirect to '/'
    elsif Helper.logged_in?(session)
      @user = Helper.current_user(session)
      if Board.exists?(params[:id])
        @board = Board.find(params[:id])
          if @board.user == @user
            erb :'boards/edit'
          else
            flash[:message] = "You don't have the permission to edit the board because it's not yours."
            redirect '/boards'
          end
      else
        flash[:message] = "The board does not exist."
        redirect '/boards'
       end
    end


    @board = Board.find(params[:id])

    erb :"boards/edit"

  end

  patch '/boards/:id' do
    @board = Board.find(params[:id])
    if !params[:name].empty?
      @board.update(name: params[:name], trip_ids: params[:trip_ids])
      @board
    else
      @board.update(trip_ids: params[:trip_ids])
    end
      redirect to "/boards/#{@board.id}"
  end

  # ------------DELETE-------------
  delete '/boards/:id/delete' do
    @board = Board.find(params[:id])
    if !Helper.logged_in?(session)
      redirect to '/login'
    elsif @board.user == Helper.current_user(session)
      @user = Helper.current_user(session)
      @board.destroy
      redirect to "/users/#{@user.slug}"
    else
      redirect to "/boards"
    end

  end

  #-------------SHOW---------------

  get '/boards' do
    if !Helper.logged_in?(session)
      flash[:message]="You have to be logged in to perform that action."
      redirect to '/'
    else
      @users = User.all
      erb :'boards/index'
    end
  end

  get '/boards/:id' do
    if Board.exists?(params[:id])
      @user = Helper.current_user(session)
      @board = Board.find(params[:id])
      erb :'boards/show'
    else
      flash[:message] = "The board does not exist."
      redirect to '/boards'
    end
  end


end
