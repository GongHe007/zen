class Api::V1::UsersController < ApiController
  def info
    render json: { success: true, user: current_user.as_json }
  end

  def create
    return render json: { success: false, msg: "密码为空" } if params[:password].blank?
    return render json: { success: false, msg: "邮箱为空" } if params[:email].blank?
    return render json: { success: false, msg: "邮箱已被注册" } if User.find_by_email(params[:email]).present?
    user = User.new(user_info)
    user.cache_create_info
    UserSignupNotifierJob.perform_later user.email, user.create_verify_code
    render json: { success: true }
  end

  def verify
    return render json: { success: false, msg: "错误验证" } if params[:email].blank? || params[:code].blank?
    user = User.new(email: params[:email])
    return redirect_to "#{ZEN_WEB_URL}/sign_in?content=验证码失效" unless user.verify_code == params[:code]
    user.assign_attributes(user.create_info)
    if user.save
      redirect_to "#{ZEN_WEB_URL}/sign_in?content=创建成功"
    else
      redirect_to "#{ZEN_WEB_URL}/sign_in?content=创建失败"
    end
  end

  def orders
    orders = Order.where(buyer_id: current_user.id).or(Order.where(seller_id: current_user.id)).where.not(status: Order::CONFIRMING).includes(:buyer, :seller)
    if params[:status].present?
      orders = orders.where(status: params[:status])
    end
    orders = orders.order("created_at desc").paginate(page: params[:page], per_page: 15)
    render json: {success: true, orders: orders.as_json(current_user_id: current_user.id)}
  end

  def advertisements
    advertisements = Advertisement.where(user_id: current_user.id)
    render json: { success: true, advertisements: { online: advertisements.online, offline: advertisements.offline } }
  end

  private

  def user_info
    params.permit(:nickname, :password, :email)
  end
end