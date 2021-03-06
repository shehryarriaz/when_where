class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    elsif user.role? :basic_user
      can :read, User, :attributes => :name
      can :show, User, id: user.id
      can :create, EventSuggestion
      can :read, EventSuggestion do |event_suggestion|
        user.invitations.where(event_suggestion_id: event_suggestion.id).any?
      end
      can :read, EventSuggestion, host_id: user.id
      can :update, EventSuggestion, host_id: user.id
      can :destroy, EventSuggestion, host_id: user.id
      can :finalise, EventSuggestion, host_id: user.id
      can :finalise_submit, EventSuggestion, host_id: user.id
      can :manage_events, EventSuggestion
      can :upcoming_events, EventSuggestion
      can :event_invitations, EventSuggestion
      can :create, Invitation
      can :create, EventChoice, user_id: user.id
      can :destroy, EventChoice, user_id: user.id
      can :accept_suggestions, EventSuggestion do |event_suggestion|
        user.invitations.where(event_suggestion_id: event_suggestion.id).any? && event_suggestion.status == 'open'
      end
      can :accept_suggestions, EventSuggestion do |event_suggestion|
        event_suggestion.host.id == user.id && event_suggestion.status == 'open'
      end
    else
      can :create, User
    end
  end
end