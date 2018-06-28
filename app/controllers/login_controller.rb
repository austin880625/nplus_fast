class LoginController < ApplicationController
    def index:

    end
    private
    def loginParam
        params.permit(:username, :password)
    end
end
