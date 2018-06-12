class Trip < ActiveRecord::Base
  has_many :board_trips
  has_many :boards, through: :board_trips
  has_many :users, through: :boards

  def self.create_from_collection
    collection = TripScraper.new.scrape_page
    collection.each do |trip_hash|
      self.create(trip_hash)
    end
  end
end
