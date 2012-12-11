# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base


def order_status(order, items,email)
  @order = order
  @items = items
  @order_email = order.email
  @deposit = order.deposit
  @balance = order.balance
  @total = order.total

  m = mail(
  :subject=>'Order Notification from Gritworks',
  :to=>"cristinarandall@gmail.com",
  :from => "payments@gritworks.com",
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
    :subject      =>"Nuevo Mensaje: " + name,
    :from         => email,
    :to   => "cristinarandall@gmail.com", #"support@gritworks.com",
    :content_type =>"text/html"#,
    ) do |format|
        format.html
    end
    m.deliver
end


end
