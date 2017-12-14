class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  def current_user
    session[:user_id] = 11
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end
end