class UserOrderNotifierJob < ActiveJob::Base
  queue_as :low_priority

  def perform user, order
    UserNotifier.send_order_notifier user, order
  end
end