  class Invitation < ActiveRecord::Base
  attr_accessible :event_suggestion_id, :invitee_id

  belongs_to :event_suggestion
  belongs_to :invitee, class_name: 'User'
end
