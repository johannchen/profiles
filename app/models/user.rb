class User < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  include Workflow

  workflow do
    state :pending_review do
      event :activate,   :transitions_to => :active
      event :reject,     :transitions_to => :rejected
    end

    state :active do
      event :inactivate, :transitions_to => :inactive
      event :reject,     :transitions_to => :rejected
    end

    state :inactive do
      event :activate,   :transitions_to => :active
    end

    state :rejected do
      event :activate,   :transitions_to => :active
    end

    on_transition do |from, to|
      if profile
        if :active == to
          profile.update_attribute(:workflow_state, 'visible')
        else
          profile.update_attribute(:workflow_state, 'hidden')
        end
      end
    end
  end

  has_one :profile, :dependent => :destroy

  scope :pending_review, where(:workflow_state => 'pending_review')

  validates_presence_of :email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :timezone

  blank_to_nil

  bitmask :roles, :as => [:admin]

  delegate :name, :to => :profile, :allow_nil => true

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
