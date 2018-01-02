class UserSignupNotifierJob < ActiveJob::Base
  queue_as :low_priority

  def perform email, code
    UserNotifier.send_signup_email(email, code).deliver
  end
end
