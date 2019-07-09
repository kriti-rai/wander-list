require 'spec_helper'

describe UserController, type: :feature do
  it "renders a form for a new user to signup" do
    visit '/signup'
    expect(page).to have_selector("form")
    expect(page).to have_field(:username)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
  end

  it "renders a form for a registered user to login" do
    visit '/login'
    expect(page).to have_selector("form")
    expect(page).to have_field(:username)
    expect(page).to have_field(:password)
  end

  before do
    params = {:username => "kriti", :password => "1234"}
    post "/login", params
    @user = User.find_by(username: params[:username])
  end

  it "sets a session id when a user successfully logs in" do
    expect(session.has_key?(:id)).to eq(true)
    expect(session[:id]).to eq(@user.id)
  end

  it 'clears session[:id] and logs a user out' do
    get '/logout'
    expect(session[:id]).to be nil
  end


end
