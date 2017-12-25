class User < ActiveRecord::Base
  has_many :advertisements
  has_many :buy_orders, class_name: "Order", foreign_key: "buyer_id"
  has_many :sell_orders, class_name: "Order", foreign_key: "seller_id"

  before_save :encrypt_password
  after_create :create_eth_wallet

  attr_accessor :password

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

  def eth_withdraw amount
    lock ETH, amount
    $eth_client.send_transaction()
  end

  def eth_wallet_address
    $redis.get(eth_wallet_address_key)
  end

  def eth_wallet_balance
    json = $eth_client.get_balance eth_wallet_address, "latest"
    json["result"].to_i(16) / 10 ** 18
  end

  def eth_total_recharge
    ($redis.get(eth_total_recharge_key) || "0").to_i
  end

  def eth_send_transaction password, reciver, value
    $eth_client.unlock_account self.eth_wallet_address, password
    params = {
      from: self.eth_wallet_address,
      to: reciver,
      gas: "0x5208",
      gasPrice: "0x9184e72a000",
      value: "0x#{(value * 10 ** 18).to_s(16)}"
    }
    json = $eth_client.send_transaction(params)
    json["result"]
  end

  def sync_eth_balance
    recharge_amount = eth_wallet_balance - eth_total_recharge
    $redis.set(eth_total_recharge_key, eth_wallet_balance)
    self.eth_balance += recharge_amount
    self.save
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

  private

  def encrypt_password
    self.encrypted_password = Digest::SHA2.hexdigest(self.password) if self.password.present?
  end

  def create_eth_wallet
    json = $eth_client.new_account("123456")
    address = json["result"]

    $redis.set(eth_wallet_address_key, address)
  end

  def eth_wallet_address_key
    "User::#{id}::ETH::WALLET_ADDRESS"
  end

  def eth_total_recharge_key
    "User::#{id}::ETH::TOTAL_RECHARGE"
  end
end
