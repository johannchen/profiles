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
    if show_all?
      Profile.visible.where(['lower(name) like ?', "%#{self.q.downcase}%"]).all
    else
      [user.profile].compact
    end
  end

  memoize :profiles
end
