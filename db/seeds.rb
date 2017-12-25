puts "run seeds"

if 0 == User.count
  100.times do |i|
    user = {
      nickname: "yolo#{i}",
      password: "123456",
      email: "934737876#{i}@qq.com",
      mobile_number: "",
      alipay_number: "18643453588",
      wx_number: "",
      bank_card_number: "",
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
      price: 3200,
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
      price: 3200,
      min_limit: 1,
      max_limit: 10000,
      time_limit: 5,
      alipay: true,
      remark: ""
    }
    Advertisement.create(params)
  end
end