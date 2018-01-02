namespace :sync_coinmarket do
  desc "sync eth"
  task :eth => :environment do
    while true
      begin
        uri = URI.parse "https://api.coinmarketcap.com/v1/ticker/ethereum/?convert=CNY"
        res = Net::HTTP.get_response uri
        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          begin
            json = JSON.parse(res.body).first
            Coinmarket.set_eth_price(json.to_json)
            puts Coinmarket.eth_price
          rescue => e
            puts e
          end
        else
          nil
        end
      rescue => e
        puts e
      end
      sleep(10.minutes.to_i)
    end
  end
end