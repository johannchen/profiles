require 'mailer_address'

class AdminMailer < ActionMailer::Base
  include MailerAddress

  default :from => Setting.s('smtp.from_address')

  def new_profile(admin)
    @profiles = Profile.includes(:user).where('users.workflow_state' => 'pending_review').order('profiles.name')
    mail(
      :to      => address(admin.email, admin.profile.name),
      :subject => I18n.t('admin.notifications.new_profile.subject', :community_name => Setting.s('community.name'))
    )
  end

  def self.new_profile_notifications
    User.with_notifications(:new_profile).each do |admin|
      AdminMailer.new_profile(admin).deliver
    end
  end
end
