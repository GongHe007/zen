1. 创建广告
  post "/api/v1/advertisements"
  params = {
    _type: 0,                 #出售/购买
    cryptocurrency_type: 0,   #货币类型
    legal_tender_type: 0,     #法币类型
    premium: 5,               #货币溢价，5代表5%
    min_price: null,          #欲出售的广告，需填写，可接受最低单价
    max_price: 1000,          #欲购买的广告，需填写，可接受最高单价
    min_limit: 1,             #最小限额
    max_limit: 10000,         #最大限额
    time_limit: 5,            #有效时间（分钟）
    alipay: true,             #是否支持支付宝
    wxpay: true,              #是否支持微信
    bankpay: true,            #是否支持银行卡
    remark: ""                #备注
    certification: false      #是否需要身份认证
  }
2. 获取广告列表
  get "/api/v1/advertisements?_type=1&page=1"
3. 获取广告信息
  get "/api/v1/advertisements/1"
4. 创建订单
  post "/api/v1/orders"
  params = {
    advertisement_id: 1,
    cryptocurrency_amount: 1,
    legal_tender_amount: 3200,
    price: 3200,
    payment: 0
  }
5. 锁单
  post "/api/v1/orders/lock"
  params = {
    order_id: 1
  }
6. 购买者确认付款
  post "/api/v1/orders/#{order_id}/buyer_check"
7. 出售者确认收款
  post "/api/v1/orders/#{order_id}/seller_check"
8. 获取订单信息
  get "/api/v1/orders/#{order_id}"
9. 获取用户订单列表
  get "/api/v1/users/orders?page=1"
10. 关闭订单
  post "/api/v1/orders/#{order_id}/close"
11. 创建用户
  post "api/v1/users"
  params = {
    password: "",
    email: ""
  }
12. 登录
  post "/api/v1/sessions"
  params = {
    email: "",
    password: ""
  }
13. 获取用户信息
  get "/api/v1/users/info"
14. 我的广告列表
  get "/api/v1/users/advertisements"
15. 获取市场价(coinmarket)
  get "/api/v1/market_price/coinmarket?type=eth"