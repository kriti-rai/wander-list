require_relative './concerns/slugifiable.rb'

class User < ActiveRecord::Base
  has_many :boards
  has_many :trips, through: :boards

  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: true

  include Slugifiable
end
