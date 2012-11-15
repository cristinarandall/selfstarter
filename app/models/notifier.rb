# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base


def company_message(message, name, telephone, email, company)
    @company_id = company.id.to_s
    @company_name = company.company_name
    @sender_email = email
    @message = message
    @name = name
    @telephone = telephone

    m = mail(
    :subject      =>"Nuevo Mensaje: " + name,
    :from         =>"\"Conekta\" <no-reply@conekta.mx>",
    :to   =>company.person_email,
    :content_type =>"text/html"#,
    ) do |format|
        format.html
    end
    m.deliver
end


end
