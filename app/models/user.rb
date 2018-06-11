require_relative './concerns/slugifiable.rb'

class User < ActiveRecord::Base
  has_many :boards
  has_many :trips, through: :boards

  has_secure_password
  validates :username, :email, :password, presence: true

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods

end
