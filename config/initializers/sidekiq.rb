require 'sidekiq'
require 'sidekiq/web'

redis_conn = proc {
  $redis
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 64, &redis_conn)
end

Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 512, &redis_conn)
end