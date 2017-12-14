class Order < ActiveRecord::Base
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id"
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :advertisement

  ALIPAY = 0
  WXPAY = 1
  BANKPAY = 2

  CONFIRMING = 0
  PAYING = 1
  CLOSED = 2
  TIMEOUT = 3
  SUCCESSED = 4

  def valid_lock_date?
    locked_at + time_limit.minutes.to_i < Time.now.to_i
  end

  def valid_advertisement?
    advertisement.online? &&
      price == advertisement.price &&
      cryptocurrency_amount * advertisement.price == legal_tender_amount &&
      legal_tender_amount >= advertisement.min_limit &&
      legal_tender_amount <= advertisement.max_limit
  end

  def lock
    return false if self.status != CONFIRMING
    Order.transaction do
      if seller.balance(cryptocurrency_type) < cryptocurrency_amount
        raise ActiveRecord::Rollback
      end
      seller.lock_balance cryptocurrency_type, cryptocurrency_amount
      update_attributes(locked_at: Time.now.to_i, status: PAYING)
    end
  end

  def clearing
    return false if self.status != PAYING
    Order.transaction do
      seller.reduce_balance cryptocurrency_type, cryptocurrency_amount
      buyer.add_balance cryptocurrency_type, cryptocurrency_amount
      update_attributes(seller_checked: true, status: SUCCESSED)
    end
  end

  def unlock
    Order.transaction do
      seller.unlock_balance cryptocurrency_type, cryptocurrency_amount
      update_attributes(status: CLOSED)
    end
  end
end