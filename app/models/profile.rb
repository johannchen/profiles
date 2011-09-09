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
  has_many :friendships
  has_many :friends, :through => :friendships

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_length_of :headline, :maximum => 50
  validates_inclusion_of :gender, :in => %w(m f), :allow_nil => true
  validates_length_of :location, :maximum => 50
  validates_length_of :phone, :maximum => 50
  validates_uniqueness_of :user_id

  attr_accessible :name, :headline, :gender, :birthday, :location, :phone, :facebook_id, :facebook_url, :image_url

  blank_to_nil

  def gender=(g)
    # FIXME this is hacky
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
end
