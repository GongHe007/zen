puts "run seeds"

if 0 == User.count
  100.times do |i|
    user = {
      nickname: "yolo#{i}",
      password: "123456",
      email: "934737876#{i}@qq.com",
      mobile_number: "",
      eth_balance: 100.0
    }
    User.create(user)
  end
  puts "finished create user"
end

if 0 == Advertisement.count
  User.first(100).each do |user|
    params = {
      user_id: user.id,
      _type: 1,
      cryptocurrency_type: 0,
      legal_tender_type: 0,
      premium: 5,
      min_price: 2000,
      min_limit: 1,
      max_limit: 10000,
      time_limit: 5,
      alipay: true,
      remark: ""
    }
    Advertisement.create(params)
  end
  User.first(100).each do |user|
    params = {
      user_id: user.id,
      _type: 0,
      cryptocurrency_type: 0,
      legal_tender_type: 0,
      premium: 5,
      max_price: 3000,
      min_limit: 1,
      max_limit: 10000,
      time_limit: 5,
      alipay: true,
      remark: ""
    }
    Advertisement.create(params)
  end
end

if 0 == Order.count
  orders = [{:buyer_id=>11, :seller_id=>1, :advertisement_id=>1, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>4, :price=>3200.0, :locked_at=>1513853560, :time_limit=>15}, {:buyer_id=>11, :seller_id=>1, :advertisement_id=>1, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>4, :price=>3200.0, :locked_at=>1513853655, :time_limit=>15}, {:buyer_id=>11, :seller_id=>1, :advertisement_id=>1, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>4, :price=>3200.0, :locked_at=>1513855542, :time_limit=>15}, {:buyer_id=>11, :seller_id=>2, :advertisement_id=>2, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>4, :price=>3200.0, :locked_at=>1513855561, :time_limit=>15}, {:buyer_id=>3, :seller_id=>11, :advertisement_id=>103, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>4, :price=>3200.0, :locked_at=>1513855670, :time_limit=>15}, {:buyer_id=>3, :seller_id=>11, :advertisement_id=>103, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.03125, :legal_tender_amount=>100.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>3, :seller_id=>11, :advertisement_id=>103, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.03125, :legal_tender_amount=>100.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>1, :seller_id=>11, :advertisement_id=>101, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>4, :price=>3200.0, :locked_at=>1513856514, :time_limit=>15}, {:buyer_id=>6, :seller_id=>11, :advertisement_id=>106, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>6, :seller_id=>11, :advertisement_id=>106, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>6, :seller_id=>11, :advertisement_id=>106, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>5, :seller_id=>11, :advertisement_id=>105, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>5, :seller_id=>11, :advertisement_id=>105, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.3125, :legal_tender_amount=>1000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>5, :seller_id=>11, :advertisement_id=>105, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>5, :seller_id=>11, :advertisement_id=>105, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>5, :seller_id=>11, :advertisement_id=>105, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}, {:buyer_id=>5, :seller_id=>11, :advertisement_id=>105, :cryptocurrency_type=>0, :cryptocurrency_amount=>0.625, :legal_tender_amount=>2000.0, :legal_tender_type=>0, :status=>0, :price=>3200.0, :locked_at=>nil, :time_limit=>15}]
  orders.each do |order|
    Order.create(order)
  end
end