class Advertisement < ActiveRecord::Base
  belongs_to :user

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

  def as_json(options = {})
    {
      id: id,
      user_nickname: user.nickname,
      _type: _type,
      cryptocurrency_type: cryptocurrency_type,
      legal_tender_type: legal_tender_type,
      price: price,
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