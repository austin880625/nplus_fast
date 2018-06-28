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
    response = Hash.new
    ride = Ride.new(ride_require.except(:passenger))
    response[:id] = ride.save ? ride.id : nil
    user = User.find_by(id: ride_require[:passenger])
    if(!user.nil?)
      user.rides.push(ride) rescue ActiveRecord::RecordNotUnique
      ride.users.push(user) rescue ActiveRecord::RecordNotUnique
    end

    
    render :json => response
  end

  private

  def ride_require
    params.permit(:title, :time_start,:time_end,:description, :driver, :from, :to, :vehicle, :passenger, :num_passenger_max)
  end
end
