require 'digest'
class LoginController < ApplicationController
    def index:
        response = Hash.new
        begin
            user = User.all.where!(username: loginParam[:username])
            digest = Digest::SHA1.hexdigest loginParam[:password]
            if digest == user.password
                prevToken = Token.all.where(user_id: user.id)
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
        rescue ActiveRecord::RecordNotFound
            response[:status] = 'faild'
        end
        render :json => response
    end
    private
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
