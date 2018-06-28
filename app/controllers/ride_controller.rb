class RideController < ApplicationController
  #skip_before_action :requireLogin, only: [:index]
  def index
    rides = Ride.all
    response = Hash.new
    response[:status] = "success"
    response[:data] = []
    rides.each do |ride|
      response[:data].push(ride)
    end
    render :json => response

  end 

  def show ## GET specific Ride
    id = params[:id]
    ride = Ride.find(id)
    render :json => ride.to_json
  end

  def create
    response = Hash.new
    ride = Ride.new(ride_require.except(:token, :user_id))
    ride.created_by = ride_require[:user_id]
    response[:id] = ride.save ? ride.id : nil
    user = User.find_by(id: ride_require[:user_id])
    response[:created_at] = ride[:created_at]
    if(!user.nil?)
      user.rides |= [ride]
    end
    render :json => response
  end

  def update
    is_driver = params[:is_driver]
    user_id = params.require(:user_id)
    ride_id = params[:id]
    ride = Ride.find(ride_id)
    user = User.find(user_id)

    user.rides |= [ride]
    #ride.users.push(user) rescue ActiveRecord::RecordNotUnique


    response = Hash.new
    if(is_driver)
      ride.driver = :user_id
    end
    response[:status] = "success"
    response[:num_of_participants] = ride.users.count
    render :json => response
  end
  def destroy
    response = Hash.new
    begin
      user_id = @user_id
      ride_id = params[:id]
      user = User.find(user_id)
      ride = Ride.find(ride_id)
      user.rides.delete(ride)
      response[:status] = 'success'
    rescue ActionController::ParameterMissing
      response[:status] = 'failed'
      response[:error] = 'user_id is required'
    end
    render :json => response
  end

  private

  def ride_require
    params.permit(:title, :time_start,:time_end,:description, :driver, :from, :to, :vehicle, :num_passenger_max, :user_id)
  end
end
