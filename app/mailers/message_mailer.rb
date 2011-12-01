class MessageMailer < ActionMailer::Base
  default :from => Setting.s('smtp.from_address')

  def email(message)
    @message = message
    from_address = Mail::Address.new(Setting.s('smtp.from_address'))
    from_address.display_name = message.from.name
    reply_to_address = Mail::Address.new(message.from.email)
    reply_to_address.display_name = message.from.name
    to_address = Mail::Address.new(message.profile.email)
    to_address.display_name = message.profile.name
    mail(
      :from     => from_address.format,
      :reply_to => reply_to_address.format,
      :to       => to_address.format,
      :subject  => message.subject
    )
  end
end
