class UserSignupNotifierJob < ActiveJob::Base
  queue_as :low_priority

  def perform user
    UserNotifier.send_signup_email(user).deliver
  end
end
