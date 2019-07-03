require 'spec_helper'

describe "User" do
  before do
    @user = User.create(username: "kriti", password: "1234", email: "kriti@test.com")
    @board_1 = Board.create(name: "Hawaii Trip")
    @board_2 = Board.create(name: "EuroTrip")
    @board_3 = Board.create(name: "SE Asia")
  end

  it "has a username" do
    expect(@user.username).to eq("kriti")
  end

  it "has an email address" do
    expect(@user.email).to eq("kriti@test.com")
  end

  it "has a password" do
    expect(@user.password).to eq("1234")
  end

  it "has many boards" do
    @user.boards << [@board_1, @board_2, @board_3]
    expect(@user.boards).to include(@board_1)
    expect(@user.boards).to include(@board_2)
    expect(@user.boards).to include(@board_3)
  end

end
