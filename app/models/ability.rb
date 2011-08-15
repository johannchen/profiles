class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    can :read, Profile
    can [:create, :update], Profile, :user => user
  end
end
