class OrderChecker
  class << self
    def run_timeout order_id, seconds
      $redis.set(checker_key(order_id), true)
      $redis.expire(checker_key(order_id), seconds)
    end

    def remove_timeout order_id
      $redis.del(checker_key(order_id))
    end

    def checker_key order_id
      "OrderChecker:#{order_id}"
    end
  end
end