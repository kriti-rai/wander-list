class User < ActiveRecord::Base
  has_many :boards
  has_many :trips, through: :boards

  has_secure_password
  validates :username, :email, :password, presence: true
end
