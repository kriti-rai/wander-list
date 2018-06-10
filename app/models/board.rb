class Board < ActiveRecord::Base
  belongs_to :user
  has_many :board_trips
  has_many :trips, through: :board_trips
end
