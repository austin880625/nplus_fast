class RideController < ApplicationController
  skip_before_action :requireLogin, only: [:create, :update]
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
    ride = Ride.new(ride_require.except(:passengers))
    response[:id] = ride.save ? ride.id : nil
    for id in :passengers do
      user.find(id).rides |= [ride]

    end
    render :json => response
  end

  private

  def ride_require
    params.require(:ride).permit(:title, :time_start,:time_end,:description, :driver, :from, :to, :vehicle, :passengers, :num_passenger_max)

  end
end
