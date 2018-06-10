class Trip < ActiveRecord::Base
  has_many :board_trips
  has_many :boards, through: :board_trips
  has_many :users, through: :boards
end
