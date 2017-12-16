namespace :order_checker do
  desc "check order timeout"
  task :check_timeout, :environment do
    $redis = Redis.new(url: "redis://127.0.0.1:6379/0")
    $redis.psubscribe("*") do |on|
      on.pmessage do |pattern, channel, msg|
        order_id = msg.gsub("OrderChecker:", "")
        order = Order.find(order_id)
        order.update_attributes(status: Order::TIMEOUT)
      end
    end
  end
end