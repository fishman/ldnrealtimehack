class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :invitable, :database_authenticatable, :registerable, :confirmable,
         # :recoverable, :rememberable, :trackable, :validatable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at


  def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    if user = User.where(:login => data.screen_name).first
      user
    else # Create a user with a stub password. 
      User.create!(:login => data.screen_name, :name => data.name, :password => Devise.friendly_token[0,20]) 
    end
  end
end
