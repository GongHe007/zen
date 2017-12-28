class Api::V1::SessionsController < ApiController
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      render json: { success: true, token: user.token }
    else
      render json: { success: false, msg: "邮箱密码不匹配" }
    end
  end
end