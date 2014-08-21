class OrderNotifier < ActionMailer::Base
  default from: "depot@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  #def received
  #  @greeting = "Hi"

  #  mail to: "to@example.org"
  #end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end
  #added code to copy the parameter passed into an instance variable and update the call 
  # to mail() specifying where to send the email and what subject line to use
  def received(order)
    @order = order
    
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
  end
end
