require 'spec_helper'

describe User do
  before do
    #{
      #:credentials=>{
        #:expires=>false,
        #:token=>"AAAC6CMHwKnsBAOCb2QgxCKzfCVrl2mEPJZCYMveN3VkxqQn0TFan7SyQm1b6A0z9tpKz7f9hCZCkUw5x4eAj5676Cq1RgZD"
      #},
      #:extra=>{
        #:raw_info=>{
          #:email=>"tim@timmorgan.org",
          #:first_name=>"Tim",
          #:gender=>"male",
          #:id=>"502335050",
          #:last_name=>"Morgan",
          #:link=>"http://www.facebook.com/seven1m",
          #:locale=>"en_US",
          #:location=>{
            #:id=>"109436565740998",
            #:name=>"Tulsa, Oklahoma"
          #},
          #:name=>"Tim Morgan",
          #:timezone=>-6,
          #:updated_time=>"2011-10-03T17:38:38+0000",
          #:username=>"seven1m",
          #:verified=true
        #}
      #},
      #:info=>{
        #:email=>"tim@timmorgan.org"
        #:first_name=>"Tim",
        #:image=>"http://graph.facebook.com/502335050/picture?type=square",
        #:last_name=>"Morgan",
        #:location=>"Tulsa, Oklahoma",
        #:name=>"Tim Morgan",
        #:nickname=>"seven1m",
        #:urls=>{
          #:Facebook=>"http://www.facebook.com/seven1m"
        #}
      #},
      #:provider=>"facebook",
      #:uid=>"502335050"
    #}
    @token = {
      "provider"     => "facebook",
      "uid"          => "000000001",
      "info"    => {
        "image"      => "http://graph.facebook.com/000000001/picture?type=square"
      },
      "extra"        => {
        "raw_info"   => {
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

  context 'given a new user with provider=nil and thirteen_or_older=false' do
    before do
      @user = Factory.build(:user, :thirteen_or_older => false)
    end

    it 'validates thirteen or older' do
      @user.errors[:thirteen_or_older].should be_true
    end
  end

  context 'given a new user with provider=nil and thirteen_or_older=nil' do
    before do
      @user = Factory.build(:user, :thirteen_or_older => nil)
    end

    it 'validates thirteen or older' do
      @user.errors[:thirteen_or_older].should be_true
    end
  end
end
