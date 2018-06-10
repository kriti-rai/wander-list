class BoardTrip < ActiveRecord::Base
  belongs_to :trip
  belongs_to :board
end
