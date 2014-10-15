class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    elsif user.role? :basic_user
      can :read, User
      can :create, EventSuggestion
      can :read, EventSuggestion
      can :update, EventSuggestion, host_id: user.id
      can :destroy, EventSuggestion, host_id: user.id
      can :create, Invitation, host_id: user.id
      can :create, EventChoice
    else
      can :create, User
    end
  end
end