if Rails.env.to_s == 'production'
  url = 'redis://172.0.0.1:6379'
else
  url = 'redis://127.0.0.1:6379'
end

$redis = Redis.new(url: "#{url}/0")