class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, omniauth_providers: [:google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :role, :email, :password, :password_confirmation, :remember_me, :event_ids, :provider, :uid
  
  has_many :invitations, foreign_key: 'invitee_id'
  has_many :events_as_invitee, through: :invitations, source: :event_suggestion

  has_many :events_as_host, foreign_key: 'host_id', class_name: 'EventSuggestion', dependent: :destroy

  has_many :event_choices
  has_many :events, through: :event_choices

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end
end