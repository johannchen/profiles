class AdminActionsPresenter
  delegate :pending_review, :to => User
  #attr_reader :pending_review

  #def initialize
    #@pending_review = User.pending_review
  #end
end
