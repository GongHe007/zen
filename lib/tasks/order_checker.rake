namespace :order_checker do
  desc "check order timeout"
  task :check_timeout => :environment do
    puts "running order checker"
    $redis.psubscribe("*") do |on|
      on.pmessage do |pattern, channel, msg|
        begin
          order_id = msg.gsub("OrderChecker:", "")
          order = Order.find(order_id)
          order.update_attributes(status: Order::TIMEOUT)
          puts "order:#{order.id} timeout"
        rescue => e
          puts e
        end
      end
    end
  end
end