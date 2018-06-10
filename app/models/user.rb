class User < ActiveRecord::Base
  has_many :boards
  has_many :trips, through: :boards
end
