require 'spec_helper'

describe "Board" do
  before do
    @board = Board.new(name: "Hawaii Trip")
    @user = User.new(username: "krai", password: "password", email: "kriti@test.com")
  end

  it "has a name" do
    expect(@board.name).to eq("Hawaii Trip")
  end

  it "belongs to a user" do
    @user.boards << @board
    expect(@board.user).to eq(@user)
  end
end
