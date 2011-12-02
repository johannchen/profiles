class Message < ActiveRecord::Base
  belongs_to :profile
  belongs_to :from, :class_name => 'Profile'

  validates_presence_of :profile
  validates_presence_of :from
  validates_inclusion_of :method, :in => ['facebook', 'mailto', 'smtp']

  attr_accessible :subject, :body
  attr_accessor :subject, :body

  def profile=(p)     write_attribute(:profile_id, p.id); set_method end
  def profile_id=(id) write_attribute(:profile_id,   id); set_method end
  def from=(f)        write_attribute(:from_id,    f.id); set_method end
  def from_id=(id)    write_attribute(:from_id,      id); set_method end

  def set_method
    if profile.try(:facebook_id) && from.try(:facebook_id)
      self.method = 'facebook'
    elsif SMTP_OK
      self.method = 'smtp'
    else
      self.method = 'mailto'
    end
  end

  after_create :send_email
  def send_email
    return unless method == 'smtp'
    MessageMailer.email(self).deliver
  end
end
