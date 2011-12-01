class Message < ActiveRecord::Base
  belongs_to :profile
  belongs_to :from, :class_name => 'Profile'

  validates_presence_of :profile
  validates_presence_of :from
  validates_inclusion_of :method, :in => ['facebook', 'mailto', 'smtp']

  attr_accessible :subject, :body
  attr_accessor :subject, :body

  def profile=(p)
    p = Profile.find(p) unless Profile === p
    write_attribute(:profile_id, p.id)
    if p.facebook_id
      self.method = 'facebook'
    elsif SMTP_OK
      self.method = 'smtp'
    else
      self.method = 'mailto'
    end
  end
  alias_method :profile_id=, :profile=

  after_create :send_email
  def send_email
    return unless method == 'smtp'
    MessageMailer.email(self).deliver
  end
end
