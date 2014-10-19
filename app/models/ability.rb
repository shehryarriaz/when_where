class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    elsif user.role? :basic_user
      can :show, User, id: user.id
      can :create, EventSuggestion
      can :read, EventSuggestion do |event_suggestion|
        user.invitations.where(event_suggestion_id: event_suggestion.id).any?
      end
      can :read, EventSuggestion, host_id: user.id
      can :update, EventSuggestion, host_id: user.id
      can :destroy, EventSuggestion, host_id: user.id
      can :create, Invitation
      can :create, EventChoice, user_id: user.id
      can :destroy, EventChoice, user_id: user.id
      can :accept_suggestions, EventSuggestion do |event_suggestion|
        user.invitations.where(event_suggestion_id: event_suggestion.id).any? && event_suggestion.status == 'open'
      end
    else
      can :create, User
    end
  end
end