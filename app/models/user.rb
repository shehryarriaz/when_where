class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :role, :email, :password, :password_confirmation, :remember_me, :event_ids, :provider, :uid
  
  has_many :invitations, foreign_key: 'invitee_id'
  has_many :events_as_invitee, through: :invitations, source: :event_suggestion

  has_many :events_as_host, foreign_key: 'host_id', class_name: 'EventSuggestion', dependent: :destroy

  has_many :event_choices
  has_many :events, through: :event_choices

  acts_as_voter

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
      user.uid = auth.uid
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
    end
  end

  def can_destroy?
    # user can destroy himself or 
    # admin user can destroy anyone only until 1 admin user is left 
    if self.role == 'basic_user' 
      return true
    elsif self.role == 'admin'
       return true if User.find_all_by_role("admin").count > 1
    else
      return false
    end
  end
end