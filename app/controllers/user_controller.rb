require 'digest'
class UserController < ApplicationController
    skip_before_action :requireLogin, only: [:login, :show]
    def me
        response = userInfo(@user_id)
        render :json => response
    end
    def show
        response = userInfo(params[:id])
        render :json => response
    end
    def update
        user = User.find(@user_id)
        liked_gift = params[:liked_gift]
        user.update(@user_id, liked_gift: liked_gift)
    end
    def login
        response = Hash.new
        begin
            user = User.where(username: loginParam[:username]).take!
            digest = Digest::SHA1.hexdigest loginParam[:password]
            if digest == user.password
                prevToken = Token.where(user_id: user.id)
                prevToken.each do |pt|
                    pt.destroy
                end
                response[:status] = 'success'
                token = Token.new
                token.user = user
                token.content = get_random_string(64)
                token.save
                response[:token] = token.content
            else
                response[:status] = 'success'
            end
        rescue ActiveRecord::RecordNotFound
            response[:status] = 'failed'
            response[:error] = 'username or password are invalid'
        end
        render :json => response
    end
    def logout
        begin
            tokenParam = params.require(:token)
        rescue ActionController::ParameterMissing
        end

        begin
            token = Token.where(content: tokenParam).take!
            token.destroy
        rescue ActiveRecord::RecordNotFound
        end
        response = Hash.new
        response[:status] = 'success'
        render :json => response
    end
    private
    def userInfo(id)
        response = Hash.new
        begin
            user = User.find(id)
            response[:status] = 'success'
            response[:username] = user.username
            rides = user.rides
            response[:rides] = {past: [], current: [], upcoming: []}
            t = Time.new
            ti = t.to_i*1000
            rides.each do |rh|
                if ti > rh.time_end.to_i
                    response[:rides][:past] << rh
                elsif ti < rh.time_end.to_i and ti > rh.time_start.to_i
                    response[:rides][:current] << rh
                elsif ti < rh.time_start
                    response[:rides][:upcoming] << rh
                end
            end
        rescue ActiveRecord::RecordNotFound
            response[:status] = 'failed'
            response[:error] = 'user not found'
        end
        response
    end
    def loginParam
        params.permit(:username, :password)
    end
    def get_random_string(length=5)
        source=("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a + ["_","-","."]
        key=""
        length.times{ key += source[rand(source.size)].to_s }
        key
    end
end
