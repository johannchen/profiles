class Search < Struct.new(:q, :user)
  extend ActiveSupport::Memoizable

  def initialize(params, user)
    self.q = params[:q]
    self.user = user
  end

  def show_all?
    user.active?
  end

  def profiles
    if user.roles?(:admin) && show_all?
      Profile.where(['lower(name) like ?', "%#{self.q.downcase}%"]).all
    elsif show_all?
      Profile.visible_or_user(user).where(['lower(name) like ?', "%#{self.q.downcase}%"]).all
    else
      [user.profile].compact
    end
  end

  memoize :profiles
end
