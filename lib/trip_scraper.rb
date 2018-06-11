require 'nokogiri'
require 'open-uri'
require 'pry'

class TripScraper
  #scrapes a list of destination from a website
  #website http://time.com/5050064/travel-and-leisure-places-to-travel-2018/
  #each trip is an instance of Trip class

  def scrape_page
    trips = []

    doc = Nokogiri::HTML(open('http://www.bbc.com/travel/destinations'))
    container = doc.css('div.primary-content')
    title = container.css('.nested-list li a').text
    binding.pry
    # doc.css('class-selector').map do |trip|
    #   trip_
  end
end
TripScraper.new.scrape_page
