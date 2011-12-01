class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.active?
        can :read, Profile
      elsif user.profile
        can :read, user.profile
      end
      if user.roles?(:admin)
        can [:create, :update, :administrate], [Profile, User]
      else
        can [:create, :update], [Profile, User], :user => user
      end
      can :create, Message
    end
  end
end
