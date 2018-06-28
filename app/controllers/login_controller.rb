require 'digest'
class LoginController < ApplicationController
    skip_before_action :requireLogin
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
            token = Token.where(content: tokenParam[:token]).take!
            token.destroy
        rescue ActiveRecord::RecordNotFound
        end
        response = Hash.new
        response[:status] = 'success'
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
