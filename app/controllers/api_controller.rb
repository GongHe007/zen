class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def current_user
    @current_user || set_current_user
  end

  private

  def set_current_user
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.find_by_token(token)
    end
    @current_user
  end
end