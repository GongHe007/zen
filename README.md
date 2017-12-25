1. 创建广告
  post "/api/v1/advertisements"
  params = {
    _type: 0,    #出售/购买
    cryptocurrency_type: 0,   #货币类型
    legal_tender_type: 0,     #法币类型
    price: 3200,              #货币单价
    min_limit: 1,             #最小限额
    max_limit: 10000,         #最大限额
    time_limit: 5,            #有效时间（分钟）
    alipay: true,             #是否支持支付宝
    remark: ""                #备注
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
  get "/api/v1/users/#{user_id}/orders?page=1"
10. 关闭订单
  post "/api/v1/orders/#{order_id}/close"