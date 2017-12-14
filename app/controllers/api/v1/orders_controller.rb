class Api::V1::OrdersController < ApiController
  def show
    order = Order.find(params[:id])
    if order.buyer_id == current_user.id || order.seller_id == current_user.id
      render json: { success: true, order: order.as_json }
    else
      render json: { success: false, msg: "订单不存在" }
    end
  end

  def create
    advertisement = Advertisement.find(params[:advertisement_id])
    unless advertisement.online?
      return render json: { success: false, msg: "广告已下架，请选择其他广告下单" }
    end

    if advertisement.user.balance(advertisement.cryptocurrency_type) < params[:cryptocurrency_amount].to_f
      return render json: { success: false, msg: "卖家余额不足" }
    end
    buyer_id = current_user.id
    seller_id = advertisement.user_id
    order = Order.new(order_info.merge(buyer_id: buyer_id, seller_id: seller_id, cryptocurrency_type: advertisement.cryptocurrency_type))
    unless order.valid_advertisement?
      return render json: { success: false, msg: "广告已更新，请重新下单" }
    end
    if order.save
      render json: { success: true, order_id: order.id, msg: "下单成功"}
    else
      render json: { success: false, msg: "下单失败"}
    end
  end

  def lock
    order = Order.find(params[:order_id])
    if order.status != Order::CONFIRMING
      return render json: { success: false, msg: "订单状态错误" }
    end
    unless order && order.valid_advertisement?
      return render json: { success: false, msg: "订单已失效，请重新下单" }
    end

    render json: { success: order.lock }
  end

  def buyer_check
    order = Order.find(params[:id])
    if order.buyer.id == current_user.id
      order.update_attributes(buyer_checked: true)
      render json: { success: true }
    else
      render json: { success: false, msg: "非法用户请求" }
    end
  end

  def seller_check
    order = Order.find(params[:id])
    if order.seller.id == current_user
      order.clearing
      render json: { success: true }
    else
      render json: { success: false, msg: "非法用户请求" }
    end
  end

  private

  def order_info
    params.permit(:advertisement_id, :cryptocurrency_amount, :legal_tender_amount, :price, :payment)
  end

end