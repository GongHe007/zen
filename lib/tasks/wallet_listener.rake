namespace :wallet_listener do
  desc "listen eth wallet balance"
  task :eth_balance => :environment do
    while true
      puts "runing"
      begin
        User.find_each do |user|
          if user.eth_wallet_balance > user.eth_total_recharge
            user.sync_eth_balance
            puts "User:#{user.id} sync eth balance"
          end
        end
      rescue => e
        puts e
      end
      puts "sleeping 60 seconds"
      sleep(60)
    end
  end
end