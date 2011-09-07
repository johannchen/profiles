class User < ActiveRecord::Base
  has_one :profile

  validates_presence_of :email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :timezone

  blank_to_nil

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    user = User.find_by_provider_and_uid('facebook', access_token["uid"]) ||
      User.find_by_email(data["email"]) ||
      User.create!(
        :provider => 'facebook',
        :uid      => access_token["uid"],
        :email    => data["email"],
        :password => Devise.friendly_token[0,20]
      )
    user.update_profile_from_access_token!(access_token)
    return user
  end

  # FIXME move this to the profile model
  def update_profile_from_access_token!(access_token)
    data = access_token['extra']['user_hash']
    profile = self.profile || build_profile
    profile.image_url    = access_token["user_info"]["image"]
    profile.gender       = {"male" => "m", "female" => "f"}[data["gender"].downcase]
    profile.facebook_url = data["link"]
    profile.name         = data["name"]
    profile.location     = data["location"] && data["location"]["name"]
    profile.phone        = data["phone"]
    profile.save!
  end
end
