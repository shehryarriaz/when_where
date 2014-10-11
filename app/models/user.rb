class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :role, :email, :password, :password_confirmation, :remember_me

  has_many :events_as_host, foreign_key: 'host_id', class_name: 'EventSuggestion', dependent: :destroy
  has_many :events_as_invitee, foreign_key: 'invitee_id', class_name: 'EventSuggestion'
end