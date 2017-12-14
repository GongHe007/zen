class User < ActiveRecord::Base
  has_many :advertisements
  has_many :buy_orders, class_name: "Order", foreign_key: "buyer_id"
  has_many :sell_orders, class_name: "Order", foreign_key: "seller_id"

  ETH = 0

  CNY = 0

  def balance cryptocurrency_type
    case cryptocurrency_type
    when ETH
      eth_balance - eth_locked_balance
    else
      0
    end
  end

  def lock_balance cryptocurrency_type, amount
    case cryptocurrency_type
    when ETH
      self.eth_locked_balance += amount
    end
    save
  end

  def unlock_balance cryptocurrency_type, amount
    case cryptocurrency_type
    when ETH
      self.eth_locked_balance -= amount
    end
    save
  end

  def add_balance cryptocurrency_type, amount
    case cryptocurrency_type
    when ETH
      self.eth_balance += amount
    end
    save
  end

  def reduce_balance cryptocurrency_type, amount
    case cryptocurrency_type
    when ETH
      self.eth_balance -= amount
      self.eth_locked_balance -= amount
    end
    save
  end
end
