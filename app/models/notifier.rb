# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base


def order_status(order, items,email)

  @discount = order.total_discount
  @shipping_cost = order.shipping_cost
  @order = order
  @items = items
  @order_email = email
  @deposit = order.deposit
  @balance = order.balance
  @total = order.total

  m = mail(
  :subject=>'Order Notification from GRiTworks',
  :to=>email,
  :from => "no-reply@gritworks.heroku.com", #payments@gritworks.com
  :content_type => "text/html"#,
  ) do |format|
    format.html
  end

  m.deliver
end


def company_message(message, name, telephone, email, company)
    @sender_email = email
    @message = message
    @name = name
    @telephone = telephone

    m = mail(
    :subject      =>"New Message: " + name,
    :from         => email,
    :to   => "payments@gritworks.com",
    :content_type =>"text/html"#,
    ) do |format|
        format.html
    end
    m.deliver
end


end
