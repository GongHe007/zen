class Api::V1::MarketPriceController < ApiController
  def coinmarket
    type = params[:type] || "eth"
    price = Coinmarket.send("#{type}_price") rescue nil
    if price
      render json: { success: true, price: price }
    else
      render json: { success: false, msg: "不存在的币种" }
    end
  end
end