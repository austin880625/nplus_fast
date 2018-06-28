class ApplicationController < ActionController::Base
  before_action :requireLogin
  protect_from_forgery with: :null_session

  private
  def requireLogin
    begin
      token = params.require(:token)
        if Token.where(content: token).empty?
          response[:status] = 'failed'
          response[:error] = 'token is invalid'
          render :json => response
        end
    rescue ActionController::ParameterMissing
      response = Hash.new
      response[:status] = 'failed'
      response[:error] = 'token is required'
      render :json => response
    end
  end
end
