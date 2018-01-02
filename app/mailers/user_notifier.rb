class UserNotifier < ActionMailer::Base
  default :from => 'noreply@creatingev.com'

  def send_signup_email email, code
    @verify_url = "#{ZEN_SITE_URL}/api/v1/users/verify?email=#{email}&code=#{code}"
    mail( to: email,
      subject: '注册验证' )
  end

  def send_order_notifier user, order
    @user = user
    @order = order
    mail( to: @user.email,
      subjuect: '下单成功' )
  end
end