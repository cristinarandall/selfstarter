# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base


def order_status(order, items,email)
  @order = order
  @items = items
  @order_email = email
  @deposit = order.deposit
  @balance = order.balance
  @total = order.total

  m = mail(
  :subject=>'Order Notification from Gritworks',
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
    :to   => "support@gritworks.com",
    :content_type =>"text/html"#,
    ) do |format|
        format.html
    end
    m.deliver
end


end
