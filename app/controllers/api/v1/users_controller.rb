class Api::V1::UsersController < ApiController
  def index
    render json: { success: true }
  end

  def create
    user = User.new(user_info)
    render json: { success: user.save }
  end

  def orders
    orders = Order.where(buyer_id: current_user.id).or(Order.where(seller_id: current_user.id))
    if params[:status].present?
      orders = orders.where(status: params[:status])
    end
    orders = orders.order("created_at desc").paginate(page: params[:page], per_page: 15)

    render json: {success: true, orders: orders.as_json(current_user_id: current_user.id)}
  end

  private

  def user_info
    params.permit(:nickname, :password, :email)
  end
end