# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base


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
