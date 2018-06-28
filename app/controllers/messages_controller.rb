class MessagesController < ApplicationController
  def talked_to
    response = Array.new
    user_ids = Message.select(:send_from, :send_to,:created_at).where(:send_from => talking_user[:id]).order(:created_at => :desc).collect(&:send_to).uniq
    users = []
    for i in 0..6 
     if(i < user_ids.length)
        user = User.find_by(:id => user_ids[i])
        if(!user.nil?)
          user_hash = Hash.new
          user_hash[:username] = user[:username]
          user_hash[:user_id] = user_ids[i]
          response.push(user_hash)
        end
        
        response.push()
     end
    end

    render :json => response
  end

  private
  def talking_user
    params.permit(:id)
  end
end
