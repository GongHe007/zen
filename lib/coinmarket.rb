class Coinmarket
  class << self
    def eth_price
      price = $redis.get(eth_price_key)
      price.present? ? JSON.parse(price) : nil
    end

    def set_eth_price price
      $redis.set(eth_price_key, price)
    end

    def eth_price_key
      "Coinmarket::ETH::Price"
    end
  end
end