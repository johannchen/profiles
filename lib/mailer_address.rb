module MailerAddress
  def address(addr, name)
    Mail::Address.new(addr).tap do |addr|
      addr.display_name = name
    end
  end
end
