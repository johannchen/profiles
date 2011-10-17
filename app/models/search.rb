class Search < Struct.new(:q)
  extend ActiveSupport::Memoizable

  def initialize(params)
    self.q = params[:q]
  end

  def profiles
    Profile.where(['lower(name) like ?', "%#{self.q.downcase}%"]).all
  end

  memoize :profiles
end
