class BoardController < ApplicationController

  #---------CREATE -----------
  get '/boards/new' do
    if !Helper.logged_in?(session)
     redirect to '/login'
   else
     @user = Helper.current_user(session)
     erb :'boards/new'
   end
  end

  post '/boards' do
    @user = Helper.current_user(session)
    # raise params.inspect
    if !!params[:name].empty?
      redirect to '/boards/new'
    else
      @board = Board.create(name: params[:name])
      @board.user = @user
      @board.save
      redirect to "/boards/#{@board.slug}"
    end
  end

  #------------EDIT--------------
  get '/boards/:slug/edit' do
    #finds board by slugified name
    #user can edit name
    #not able to add/del trips because there are so many
    if !Helper.logged_in?(session)
      redirect to '/login'
    elsif Helper.logged_in?(session)
      @user = Helpers.current_user(session)
      if !Board.find_by_slug(params[:slug])
        # flash[:message] = "The board does not exist."
        redirect '/boards'
      elsif @board = Board.find_by_slug(params[:slug])
          if @board.user == @user
            erb :'boards/edit'
          else
            # flash[:message] = "You don't have the permission to edit the board because it's not yours."
            redirect '/boards'
          end
       end
    end


    @board = Board.find_by(params[:slug])

    erb :"boards/edit"

  end

  get '/boards/:slug' do
    #replace get with patch
    @board = Board.find_by_slug(params[:slug])
    if !!params[:name].empty?
      redirect to "/boards/#{@board.slug}/edit"
    else
      @board.update(name: params[:name])
      redirect to "/boards/#{@board.slug}"
    end
  end

  # ------------DELETE-------------
  get '/boards/:slug/delete' do
    #replace get with delete
    @board = Board.find_by(params[:slug])
    @board.destroy
    if !Helper.logged_in?(session)
      # flash[:message] = "ATTENTION: You must be logged in to perform this action."
      redirect to '/login'
    elsif @board.user == Helper.current_user(session)
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
      redirect to '/login'
    else
      @user = Helper.current_user(session)
      @boards = Board.all
      erb :'boards/index'
    end
  end

  get '/boards/:slug' do
    if !Helper.logged_in?(session)
      redirect to '/login'
    else
      @board = Board.find_by_slug(params[:slug])
      erb :'boards/show'
    end
  end


end
