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
    before do
      @user = Factory.create(:user, :provider => 'facebook', :uid => @token['uid'])
    end

    subject { User.find_and_update(@token) }

    it 'reuses the existing user record' do
      subject.id.should eq(@user.id)
    end

    it 'updates the profile' do
      subject.profile.name.should eq('John Doe')
    end

    it 'updates the email' do
      subject.email.should eq('john@example.com')
    end
  end

  context 'given a new facebook uid with an existing email address' do
    before do
      @user = Factory.create(:user, :email => 'john@example.com')
    end

    subject { User.find_and_update(@token) }

    it 'reuses the existing user record' do
      subject.id.should eq(@user.id)
    end

    it 'updates the uid' do
      subject.provider.should eq('facebook')
      subject.uid.should eq('000000001')
    end
  end

  context 'given a new facebook uid and new email address' do
    it 'creates a new user' do
      lambda {
        User.find_and_update(@token)
      }.should change(User, :count).by(1)
    end
  end
end
