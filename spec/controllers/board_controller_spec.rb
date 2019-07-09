require 'spec_helper'

describe BoardController do

  describe "GET '/boards/new'" do

    before(:example) do
      visit '/logout'
      @user1 = User.create(username: "keanu", password: "1234", email: "keanu@test.com")
    end

    after(:example) do
      @user1.destroy
    end

    it "shows error message if a user who is not logged in goes directly to /boards/new" do
      visit '/boards/new'
      expect(page.body).to include("You have to be logged in to perform that action.")
    end

    it "allows a user who is logged in to view a form to create a new board" do
      params = {username: "keanu", password: "1234"}
      visit '/login'
      fill_in :username, :with => params[:username]
      fill_in :password, :with => params[:password]

      click_button 'submit'

      visit '/boards/new'
      expect(page.body).to include('<form')
    end
  end

  describe "edit board" do

    before(:example) do
      # visit '/logout'
      @user2 = User.create(username: "sasha", password: "1234", email: "sasha@test.com")
      @board = Board.new(name: "Southeast Asia")
      @board.user = @user2
      @board.save
    end

    after(:example) do
      @user2.destroy
      @board.destroy
    end

    it "shows error message if a user who is not logged in goes directly to /boards/:id/edit" do
      visit "/boards/#{@board.id}/edit"
      expect(page.body).to include("You have to be logged in to perform that action.")
    end

    it "does not allow a user to edit a board that doesn't belong to them" do
      params1 = {username: "keanu", password: "1234"}
      visit '/login'
      fill_in :username, :with => params1[:username]
      fill_in :password, :with => params1[:password]

      click_button 'submit'

      visit "/boards/#{@board.id}/edit"
      expect(page.body).to include("You don't have the permission to edit the board because it's not yours.")
    end

    it "allows a user who is logged in and owns the board to edit the board" do
      params2 = {username: "sasha", password: "1234"}
      visit '/login'
      fill_in :username, :with => params2[:username]
      fill_in :password, :with => params2[:password]

      click_button 'submit'

      visit "/boards/#{@board.id}/edit"
      expect(page.body).to include('<form')
    end
  end

end
