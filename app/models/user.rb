class User < ActiveRecord::Base
  has_many :advertisements
  has_many :buy_orders, class_name: "Order", foreign_key: "buyer_id"
  has_many :sell_orders, class_name: "Order", foreign_key: "seller_id"

  after_create :create_eth_wallet
  before_save :generate_nickname
  before_save :generate_token
  before_save :encrypt_password

  validates :nickname, uniqueness: true
  validates :email, uniqueness: true, presence: true
  validates :token, uniqueness: true

  attr_accessor :password

  ETH = 0

  CNY = 0

  def as_json(options = {})
    {
      id: id,
      nickname: nickname,
      email: email,
      eth_balance: eth_balance,
      eth_locked_balance: eth_locked_balance
    }
  end

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

  def self.authenticate email, password
    user = User.find_by_email(email)
    if user && user.encrypted_password == Digest::SHA2.hexdigest(password)
      user
    else
      nil
    end
  end

  def cache_create_info
    $redis.set(create_info_key, {email: email, password: password}.to_json)
  end

  def create_info
    info = $redis.get(create_info_key)
    info.present? ? JSON.parse(info) : nil
  end

  def create_verify_code
    code = self.verify_code || rand(1000 .. 9999).to_s
    $redis.set(verify_code_key, code)
    $redis.expire(verify_code_key, 300.seconds)

    code
  end

  def verify_code
    $redis.get(verify_code_key)
  end

  private

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64

    true
  end

  def encrypt_password
    self.encrypted_password = Digest::SHA2.hexdigest(self.password) if self.password.present?
  end

  def create_eth_wallet
    json = $eth_client.new_account("123456")
    address = json["result"]

    $redis.set(eth_wallet_address_key, address)
  end

  def generate_nickname
    self.nickname ||= self.email
    true
  end

  def eth_wallet_address_key
    "User::#{id}::ETH::WalletAddress"
  end

  def eth_total_recharge_key
    "User::#{id}::ETH::TotalRecharge"
  end

  def token_key
    "User::#{id}::Token"
  end

  def create_info_key
    "User::#{email}::CreateInfo"
  end

  def verify_code_key
    "User::#{email}::Code"
  end
end
