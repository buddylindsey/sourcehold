class User < ActiveRecord::Base
  include Gravtastic
  gravtastic :secure => :true, :size => 50

  has_and_belongs_to_many :roles
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username

  has_many :repositories
  has_many :authorized_keys
  has_many :permissions
  has_many :emails
  has_one :profile

  validates_presence_of :username
  validates_uniqueness_of :username

  def avatar
      return self.gravatar_url
  end
  

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
end
