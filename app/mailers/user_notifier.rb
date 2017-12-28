class UserNotifier < ActionMailer::Base
  default :from => 'noreply@creatingev.com'

  def send_signup_email user
    @user = user
    @code = @user.create_verify_code
    @verify_url = "#{ZEN_SITE_URL}/api/v1/users/verify?email=#{@user.email}&code=#{@code}"
    mail( to: @user.email,
      subject: '注册验证' )
  end

  def send_order_notifier user, order
    @user = user
    @order = order
    mail( to: @user.email,
      subjuect: '下单成功' )
  end
end