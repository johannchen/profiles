class UserMailer < ActionMailer::Base
  def activation_email(admin, user)
    @user = user
    mail(:from => admin.email, :to => user.email, :subject => "Welcome to DCCC Directory. Your profile has been approved!")
  end

  def rejection_email(admin, user)
    @user = user
    mail(:from => admin.email, :to => user.email, :subject => "Sorry, your profile to DCCC Directory has been rejected.")
  end
end
