class User < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_one :profile, :dependent => :destroy

  validates_presence_of :email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :timezone

  blank_to_nil

  # assumes a fresh fb_token (set when user logs in)
  def graph
    FbGraph::User.me(fb_token)
  end
  memoize :graph

  # FIXME this should not have side effects
  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    user = User.find_by_provider_and_uid('facebook', access_token["uid"]) ||
      User.find_by_email(data["email"]) ||
      User.new do |u|
        u.provider = 'facebook'
        u.uid      = access_token["uid"]
        u.email    = data["email"]
        u.password = Devise.friendly_token[0,20]
      end
    user.fb_token = access_token["credentials"]["token"]
    user.save!
    user.update_profile_from_oauth_access_token!(access_token)
    user.profile.update_friends!
    return user
  end

  def update_profile_from_oauth_access_token!(access_token)
    profile = self.profile || build_profile
    profile.update_from_oauth_access_token!(access_token)
  end
end
