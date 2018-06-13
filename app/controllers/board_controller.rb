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
    #finds board by slugified name
    #user can edit name
    #not able to add/del trips because there are so many
    if !Helper.logged_in?(session)
      redirect to '/login'
    elsif Helper.logged_in?(session)
      @user = Helper.current_user(session)
      if !Board.find(params[:id])
        # flash[:message] = "The board does not exist."
        redirect '/boards'
      elsif @board = Board.find(params[:id])
          if @board.user == @user
            erb :'boards/edit'
          else
            # flash[:message] = "You don't have the permission to edit the board because it's not yours."
            redirect '/boards'
          end
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
    #replace get with delete
    @board = Board.find(params[:id])
    if !Helper.logged_in?(session)
      # flash[:message] = "ATTENTION: You must be logged in to perform this action."
      redirect to '/login'
    elsif @board.user == Helper.current_user(session)
      @user = Helper.current_user(session)
      @board.destroy
      redirect to "/users/#{@user.slug}"
    else
      # flash[:message]= "You don't have the permission to delete this tweet because it's not yours."
      redirect to "/boards"
    end

  end


  #-------------SHOW---------------

  get '/boards' do
    if !Helper.logged_in?(session)
      redirect to '/'
    else
      @user = Helper.current_user(session)
      @users = User.all
      erb :'boards/index'
    end
  end

  get '/boards/:id' do
    # if !Helper.logged_in?(session)
    #   redirect to '/'
    # else
      @user = Helper.current_user(session)
      @board = Board.find(params[:id])
      erb :'boards/show'
    # end
  end


end
