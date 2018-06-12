class TripController < ApplicationController
  get '/trips' do
    @trips = Trip.all.sort_by{|trip| trip.name}
    # binding.pry
    erb :'trips/index'
  end
end
