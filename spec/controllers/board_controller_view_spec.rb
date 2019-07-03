require 'spec_helper'

describe BoardController do

  describe "GET '/boards/new'" do
    it "shows error message if a user who is not logged in goes directly to /boards/new" do
      visit '/boards/new'
      expect(page.body).to include("You have to be logged in to perform that action.")
    end

    it "allows the logged in user to view a form to create a new board" do
      user1 = User.create(username: "jwick", password: "1234", email: "jwick@test.com")
      params = {username: "jwick", password: "1234"}
      visit '/login'
      fill_in :username, :with => params[:username]
      fill_in :password, :with => params[:password]

      click_button 'submit'

      visit '/boards/new'
      expect(page.body).to include('<form')
    end
  end

end
