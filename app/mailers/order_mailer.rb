class OrderMailer < ApplicationMailer

  def order_email(order)
    @order = order
    mail(to: @order.email, subject: 'Your order has been processed!')
  end
end
