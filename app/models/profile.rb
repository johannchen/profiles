class Profile < ActiveRecord::Base

  include Workflow
  workflow do
    state :pending_review do
      event :approve, :transitions_to => :visible
      event :reject,  :transitions_to => :rejected
    end
    state :visible do
      event :hide,    :transitions_to => :hidden
      event :reject,  :transitions_to => :rejected
    end
    state :hidden do
      event :unhide,  :transitions_to => :visible
    end
    state :rejected do
      event :approve, :transitions_to => :visible
    end
  end

  belongs_to :user
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_one :theme, :order => 'id', :dependent => :destroy

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_length_of :headline, :maximum => 50
  validates_inclusion_of :gender, :in => %w(m f), :allow_nil => true
  validates_length_of :location, :maximum => 50
  validates_length_of :phone, :maximum => 50
  validates_uniqueness_of :user_id

  attr_accessible :name, :headline, :gender, :birthday, :location, :phone, :facebook_id, :facebook_url, :small_image_url, :full_image_url

  blank_to_nil

  # alerts
  bitmask :alerts, :as => [:new, :new_theme]
  before_create { alerts << :new }
  def new_theme_alert!
    alerts << :new_theme
    save(:validate => false)
  end

  # FIXME this is hacky
  def gender=(g)
    g = nil if g == 'nil'
    write_attribute(:gender, g)
  end

  def update_attributes_with_user(attributes, user_attributes)
    if update_attributes(attributes) && user.update_attributes(user_attributes)
      true
    else
      user.errors.full_messages.each { |m| errors.add(:base, m) }
      false
    end
  end

  def update_from_oauth_access_token!(access_token)
    data = access_token['extra']['user_hash']
    self.small_image_url = "http://graph.facebook.com/#{access_token['uid']}/picture?type=square"
    self.full_image_url  = "http://graph.facebook.com/#{access_token['uid']}/picture?type=large"
    self.gender          = {"male" => "m", "female" => "f"}[data["gender"].downcase]
    self.facebook_url    = data["link"]
    self.name            = data["name"]
    self.location        = data["location"] && data["location"]["name"]
    self.phone           = data["phone"]
    save!
  end

  # should only be called when the user is logged in
  # (effectively self.user is expected to be the current_user with an updated fb_token)
  def update_friends!
    ids = user.graph.friends.map(&:identifier)
    profiles = User.includes(:profile).where(
      'users.provider'          => 'facebook',
      'users.uid'               => ids,
      'profiles.workflow_state' => 'visible'
    ).map(&:profile)
    self.friends = profiles
  end

  def create_theme!
    Theme.build_random(:profile => self).save!
    reload
  end
end
