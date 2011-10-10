require 'spec_helper'

describe User do
  before do
    @token = {
      "provider"     => "facebook",
      "uid"          => "000000001",
      "user_info"    => {
        "image"      => "http://graph.facebook.com/000000001/picture?type=square"
      },
      "extra"        => {
        "user_hash"  => {
          "id"       => "502335050",
          "name"     => "John Doe",
          "link"     => "http://www.facebook.com/seven1m",
          "username" => "seven1m",
          "gender"   => "male",
          "email"    => "john@example.com",
          "timezone" => -5,
          "location" => {
            "id"     => "109436565740998",
            "name"   => "Tulsa, Oklahoma"
          }
        }
      },
      "credentials"  => {
        "token"      => "abc123"
      }
    }
    Profile.any_instance.stubs(:update_friends!)
  end

  context 'given an existing facebook uid' do
    it 'updates the profile' do
      @user = User.find_for_facebook_oauth(@token)
      @user.profile.name.should eq('John Doe')
    end
  end

  context 'given a new facebook uid with an existing email address' do
    before do
      @existing_user = Factory.create(:user)
      @token_with_same_email = @token.dup
      @token_with_same_email['extra']['user_hash']['email'] = @existing_user.email
    end

    it 'reuses the existing user record' do
      @user = User.find_for_facebook_oauth(@token)
      @user.id.should eq(@existing_user.id)
    end
  end
end
