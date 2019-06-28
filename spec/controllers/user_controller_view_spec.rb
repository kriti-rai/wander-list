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
    visit '/signup'
    expect(page).to have_selector("form")
    expect(page).to have_field(:username)
    expect(page).to have_field(:password)
  end

  # it "logs a user out" do
  #   visit '/logout'
  #   expect(set_rack_session[:id]).to eq(nil)
  # end

end
