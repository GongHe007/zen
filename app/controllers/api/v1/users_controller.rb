class Api::V1::UsersController < ApiController
  def index
    render json: { success: true }
  end
end