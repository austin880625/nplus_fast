class MessagesController < ApplicationController
  def talked_to
    response = Array.new
    user_ids = Message.select(:send_from, :send_to,:created_at).where(:send_from => talking_user[:user_id]).order(:created_at => :desc).collect(&:send_to).uniq
    users = []
    #rides = User.find(params[:user_id]).rides
    for i in 0..6 
     if(i < user_ids.length)
        user = User.find_by(:id => user_ids[i])
        if(!user.nil?)
          user_hash = Hash.new
          user_hash[:username] = user[:username]
          user_hash[:user_id] = user_ids[i]
          user_hash[:liked_gift] = user[:liked_gift]
          user_hash[:current_party] = []

          

          #user_hash[:past_party] = 
          response.push(user_hash)
        end
     end
    end

    render :json => response
  end

  def show #get all messages with user[:id]
    friend_id = params.require(:id)
    user_id = params.require(:user_id)
    msgs = Message.where(:send_from => user_id, :send_to => friend_id).or(Message.where(:send_to => user_id, :send_from => friend_id)).select(:id ,:send_from, :send_to, :content, :created_at).order(:created_at => :desc)

    rides = User.find(user_id).rides
    current_party = []
    friend = User.find(friend_id)
    liked_gift = friend[:liked_gift]
    past_party = []
    time = Time.new
    time = time.to_i*1000
    rides.each do |ride|
      if ride.users.include?(friend)
        if(time <= ride[:time_end].to_i)
           current_party.push(ride[:title])
        else
           past_party.push(ride[:title])
        end
      end
    end
    render :json => {msg: msgs,liked_gift: liked_gift,current_party: current_party,past_party:past_party}
  end

  def send_msg
    msg_params = params.permit(:user_id, :content,:id)
    msg = Message.create(:send_from => msg_params[:user_id], :send_to => params[:id], :content => msg_params[:content])
    render :json => {"status":"success"}
  end
  private
  def talking_user
    params.permit(:user_id)
  end
end
