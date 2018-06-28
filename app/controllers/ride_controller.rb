class RideController < ApplicationController
  def index
    rides = Ride.all
    response = Hash.new
    response[:status] = "succeed"
    response[:data] = []
    rides.each do |ride|
      response[:data].push(ride)
    end
    render :json => response

  end
  
  def create
  
  end
end
