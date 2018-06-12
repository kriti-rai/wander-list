require 'nokogiri'
require 'open-uri'
require 'pry'

class TripScraper
  def scrape_page
    trip_hash_array = []

    doc = Nokogiri::HTML(open('http://www.bbc.com/travel/destinations'))
    links = doc.css('div.primary-content').css('.section-body a')
    links.each do |link|
      trip_hash = {
        :name => link.text.gsub(/\n/,""),
        :url => link.attribute('href').to_s
      }
      trip_hash_array << trip_hash
    end
    trip_hash_array
  end
end
