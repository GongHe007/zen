class Advertisement < ActiveRecord::Base
  belongs_to :user

  validates :max_price, presence: true, if: "_type == BUY"
  validates :min_price, presence: true, if: "_type == SELL"

  ONLINE = 0
  OFFLINE = 1

  BUY = 0
  SELL = 1

  scope :online,    -> { where(status: ONLINE) }
  scope :offline,    -> { where(status: OFFLINE) }

  def real_max_limit
    user_balance = user.balance(cryptocurrency_type) * price
    user_balance < max_limit ? user_balance : max_limit
  end

  def online?
    status == ONLINE ? true : false
  end

  def price
    eth_price = Coinmarket.eth_price["price_cny"].to_f
    premium_price = eth_price * (100 + premium) / 100
    case _type
    when BUY
      premium_price > max_price ? max_price : premium_price
    when SELL
      premium_price < min_price ? min_price : premium_price
    end
  end

  def as_json(options = {})
    {
      id: id,
      user_nickname: user.nickname,
      user_id: user_id,
      _type: _type,
      cryptocurrency_type: cryptocurrency_type,
      legal_tender_type: legal_tender_type,
      price: price,
      premium: premium,
      min_limit: min_limit,
      max_limit: real_max_limit ,
      time_limit: time_limit,
      alipay: alipay,
      wxpay: wxpay,
      bankpay: bankpay,
      remark: remark
    }
  end
end