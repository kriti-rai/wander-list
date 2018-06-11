require_relative './concerns/slugifiable.rb'

class Board < ActiveRecord::Base
  belongs_to :user
  has_many :board_trips
  has_many :trips, through: :board_trips

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
