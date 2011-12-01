require 'bitmask_accessor'

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

  validates_each :thirteen_or_older do |record, attr, val|
    if record.provider.nil? and not val
      record.errors.add(attr, :invalid)
    end
  end

  validates_each :notifications do |record, attr, val|
    if record.notifications?(:new_profile) && !record.roles?(:admin)
      record.errors.add(attr, :invalid)
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :timezone, :thirteen_or_older
  attr_accessible :admin, :new_profile_notification, :as => :admin

  blank_to_nil

  bitmask :roles,         :as => [:admin]
  bitmask :notifications, :as => [:new_profile]

  bitmask_accessor :roles,         :admin
  bitmask_accessor :notifications, :new_profile, :suffix => '_notification'

  delegate :name, :to => :profile, :allow_nil => true

  before_create :make_admin_if_only_user

  # assumes a fresh fb_token (set when user logs in)
  def graph
    FbGraph::User.me(fb_token)
  end
  memoize :graph

  def self.find_and_update(access_token)
    data = access_token['extra']['raw_info']
    user = User.find_by_provider_and_uid('facebook', access_token["uid"]) ||
      User.find_by_email(data['email']) ||
      User.new(:password => Devise.friendly_token[0,20])
    user.fb_token = access_token['credentials']['token']
    user.provider = 'facebook'
    user.uid      = access_token['uid']
    user.email    = data['email']
    user.save!
    user.update_profile_from_oauth_access_token!(access_token)
    user.profile.update_friends!
    return user
  end

  def update_profile_from_oauth_access_token!(access_token)
    profile = self.profile || build_profile
    profile.update_from_oauth!(access_token)
  end

  private

  def make_admin_if_only_user
    if User.count == 0
      roles << :admin
      notifications << :new_profile
    end
  end
end
