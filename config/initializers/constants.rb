if Rails.env.production?
elsif Rails.env.development?
  ZEN_SITE_URL = "http://192.168.1.170:3000"
  ZEN_WEB_URL = "http://192.168.1.114:3000"
end