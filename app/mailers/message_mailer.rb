require 'mailer_address'

class MessageMailer < ActionMailer::Base
  include MailerAddress

  default :from => Setting.s('smtp.from_address')

  def email(message)
    @message = message
    mail(
      :from     => address(Setting.s('smtp.from_address'), message.from.name),
      :reply_to => address(message.from.email, message.from.name),
      :to       => address(message.profile.email, message.profile.name),
      :subject  => message.subject
    )
  end
end
